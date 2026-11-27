import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/blood_request.dart';
import '../../../../domain/models/donor_profile.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/request_response.dart';
// TEMP: replace with Siham's provider once T3 is merged.
import '../../../auth/presentation/providers/current_user_provider.dart';
import '../../../matching/presentation/providers/matching_providers.dart';
import 'donor_profile_providers.dart';
import 'matching_requests_providers.dart';

/// Can the signed-in user respond to this request? (and if not, why)
enum RespondEligibility {
  signedOut('Please sign in to respond.'),
  ownRequest('This is your own request.'),
  alreadyResponded('You already responded to this request.'),
  notOpen('This request is no longer open.'),
  noProfile('Complete your donor profile to respond.'),
  unavailable(
    'You are marked as unavailable. Turn availability on in your profile to respond.',
  ),
  bloodTypeMismatch('Your blood type does not match this request.'),
  canRespond('');

  const RespondEligibility(this.message);

  final String message;
}

/// Pure rule: easy to test, no UI and no providers.
RespondEligibility checkRespondEligibility({
  required BloodRequest request,
  required String? userId,
  required DonorProfile? profile,
  required bool alreadyResponded,
}) {
  if (userId == null) return RespondEligibility.signedOut;
  if (request.requesterId == userId) return RespondEligibility.ownRequest;
  if (alreadyResponded) return RespondEligibility.alreadyResponded;
  if (request.status != RequestStatus.open) return RespondEligibility.notOpen;
  if (profile == null) return RespondEligibility.noProfile;
  if (!profile.isAvailable) return RespondEligibility.unavailable;
  if (profile.bloodType != request.bloodTypeNeeded) {
    return RespondEligibility.bloodTypeMismatch;
  }
  return RespondEligibility.canRespond;
}

/// The signed-in donor's response to one request (null if none yet).
final myResponseProvider = FutureProvider.family<RequestResponse?, String>((
  ref,
  requestId,
) async {
  final profile = await ref.watch(myDonorProfileProvider.future);
  if (profile == null) return null;
  final responses = await ref
      .watch(matchingRepositoryProvider)
      .getResponses(requestId);
  for (final response in responses) {
    if (response.donorId == profile.id) return response;
  }
  return null;
});

/// Sends a response. State = ids of requests being sent right now.
final respondControllerProvider =
    NotifierProvider<RespondController, Set<String>>(RespondController.new);

class RespondController extends Notifier<Set<String>> {
  @override
  Set<String> build() => const <String>{};

  /// Returns an error message, or null when the response was saved.
  Future<String?> respond(BloodRequest request) async {
    if (state.contains(request.id)) return null;

    final userId = ref.read(currentUserProvider)?.id;
    final profile = await ref.read(myDonorProfileProvider.future);
    final existing = await ref.read(myResponseProvider(request.id).future);
    final eligibility = checkRespondEligibility(
      request: request,
      userId: userId,
      profile: profile,
      alreadyResponded: existing != null,
    );
    if (profile == null || eligibility != RespondEligibility.canRespond) {
      return eligibility.message;
    }

    state = {...state, request.id};
    try {
      await ref
          .read(matchingRepositoryProvider)
          .respondToRequest(requestId: request.id, donorId: profile.id);
      ref.invalidate(myResponseProvider(request.id));
      ref.invalidate(requestResponsesProvider(request.id));
      ref.invalidate(matchingRequestsProvider);
      return null;
    } catch (error) {
      return 'Could not respond: $error';
    } finally {
      state = {...state}..remove(request.id);
    }
  }
}

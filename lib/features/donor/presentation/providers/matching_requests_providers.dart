import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/blood_request.dart';
import '../../../../domain/models/donor_profile.dart';
import '../../../../domain/models/enums.dart';
// TEMP: replace with Siham's provider once T3 is merged.
import '../../../auth/presentation/providers/current_user_provider.dart';
import '../../../requests/presentation/providers/requests_providers.dart';
import 'donor_profile_providers.dart';

/// One row of the donor's Home list.
typedef MatchingRequestItem = ({BloodRequest request, bool hasResponded});

/// Which open requests should this donor see?
/// - still open
/// - not posted by the donor themselves
/// - needing the donor's blood type (exact match, same rule as the matching repo)
/// Most urgent first, then newest first.
List<BloodRequest> filterRequestsForDonor({
  required List<BloodRequest> requests,
  required DonorProfile profile,
  required String currentUserId,
}) {
  final matching = requests
      .where(
        (r) =>
            r.status == RequestStatus.open &&
            r.requesterId != currentUserId &&
            r.bloodTypeNeeded == profile.bloodType,
      )
      .toList();
  matching.sort((a, b) {
    final byUrgency = b.urgency.index.compareTo(a.urgency.index);
    if (byUrgency != 0) return byUrgency;
    return b.createdAt.compareTo(a.createdAt);
  });
  return matching;
}

/// Open requests matching the signed-in donor. Empty when there is no profile.
///
/// Rebuilds whenever openRequestsProvider does (create / fulfill) and when the
/// donor profile changes. The list also supports pull-to-refresh.
final matchingRequestsProvider = FutureProvider<List<MatchingRequestItem>>((
  ref,
) async {
  final user = ref.watch(currentUserProvider);
  final profile = await ref.watch(myDonorProfileProvider.future);
  if (user == null || profile == null) return const [];

  // Built on openRequestsProvider, so creating or fulfilling a request
  // (which invalidates it) refreshes this list automatically.
  final open = await ref.watch(openRequestsProvider.future);
  final matching = filterRequestsForDonor(
    requests: open,
    profile: profile,
    currentUserId: user.id,
  );

  final matchingRepo = ref.watch(matchingRepositoryProvider);
  final items = <MatchingRequestItem>[];
  for (final request in matching) {
    final responses = await matchingRepo.getResponses(request.id);
    items.add((
      request: request,
      hasResponded: responses.any((r) => r.donorId == profile.id),
    ));
  }
  return items;
});

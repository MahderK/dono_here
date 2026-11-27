import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/blood_request.dart';
import '../../../../domain/models/enums.dart';

/// Default hospital-area coordinates (central Addis Ababa) used in Milestone 1,
/// because the create-request form does not collect a location yet.
const double defaultRequestLatitude = 9.0300;
const double defaultRequestLongitude = 38.7400;

/// TEMPORARY SEAM until T3 (auth) is merged.
///
/// Returns the id of the signed-in user. Once the auth provider exists, change
/// the body to e.g. `ref.watch(currentUserProvider)?.id` and nothing else in
/// the requests feature needs to change. Tests override this provider.
final currentRequesterIdProvider = Provider<String?>((ref) => 'user-1');

/// The signed-in user's own blood requests, newest first.
final myRequestsProvider =
    AsyncNotifierProvider<MyRequestsNotifier, List<BloodRequest>>(
      MyRequestsNotifier.new,
    );

class MyRequestsNotifier extends AsyncNotifier<List<BloodRequest>> {
  @override
  Future<List<BloodRequest>> build() async {
    final requesterId = ref.watch(currentRequesterIdProvider);
    final repository = ref.watch(bloodRequestRepositoryProvider);
    if (requesterId == null) return const [];

    final requests = await repository.getRequestsByRequester(requesterId);
    return [...requests]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Creates an open request owned by the current user and refreshes the list.
  Future<BloodRequest> createRequest({
    required BloodType bloodType,
    required int units,
    required String hospital,
    required RequestUrgency urgency,
  }) async {
    final requesterId = ref.read(currentRequesterIdProvider);
    if (requesterId == null) {
      throw StateError('You must be signed in to post a request.');
    }

    final now = DateTime.now();
    final request = BloodRequest(
      id: 'request-${now.microsecondsSinceEpoch}',
      requesterId: requesterId,
      hospital: hospital.trim(),
      bloodTypeNeeded: bloodType,
      unitsNeeded: units,
      latitude: defaultRequestLatitude,
      longitude: defaultRequestLongitude,
      urgency: urgency,
      status: RequestStatus.open,
      createdAt: now,
    );

    final saved = await ref
        .read(bloodRequestRepositoryProvider)
        .saveRequest(request);
    ref.invalidateSelf();
    await future;
    return saved;
  }
}

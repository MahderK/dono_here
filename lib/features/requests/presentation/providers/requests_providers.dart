import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../domain/models/blood_request.dart';
import '../../../../domain/models/enums.dart';
import '../../../auth/presentation/providers/current_user_provider.dart';

/// Default hospital-area coordinates (central Addis Ababa) used in Milestone 1,
/// because the create-request form does not collect a location yet.
const double defaultRequestLatitude = 9.0300;
const double defaultRequestLongitude = 38.7400;

/// The signed-in requester id. Auth is now the single source of truth.
final currentRequesterIdProvider = Provider<String?>(
  (ref) => ref.watch(currentUserProvider)?.id,
);

/// All open requests, newest first (shown on Home).
final openRequestsProvider = FutureProvider<List<BloodRequest>>((ref) async {
  final requests = await ref
      .watch(bloodRequestRepositoryProvider)
      .getOpenRequests();
  return [...requests]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
});

/// One request by id (shown on the detail screen). `null` means not found.
final requestDetailProvider = FutureProvider.family<BloodRequest?, String>((
  ref,
  id,
) {
  return ref.watch(bloodRequestRepositoryProvider).getRequest(id);
});

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

  /// Creates an open request owned by the current user and refreshes the lists.
  Future<BloodRequest> createRequest({
    required BloodType bloodType,
    required int units,
    required String hospital,
    required String area,
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
      area: area.trim(),
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
    ref.invalidate(openRequestsProvider);
    await future;
    return saved;
  }

  /// Marks one of the current user's requests as fulfilled and refreshes
  /// every list that shows it (My Requests, Home, detail).
  Future<void> fulfillRequest(String requestId) async {
    final requesterId = ref.read(currentRequesterIdProvider);
    final repository = ref.read(bloodRequestRepositoryProvider);

    final request = await repository.getRequest(requestId);
    if (request == null) {
      throw StateError('Request not found.');
    }
    if (requesterId == null || request.requesterId != requesterId) {
      throw StateError('Only the requester can mark a request as fulfilled.');
    }

    await repository.saveRequest(
      request.copyWith(status: RequestStatus.fulfilled),
    );
    ref.invalidateSelf();
    ref.invalidate(openRequestsProvider);
    ref.invalidate(requestDetailProvider(requestId));
    await future;
  }
}
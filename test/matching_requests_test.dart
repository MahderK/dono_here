import 'package:dono_here/data/seed/seed_data.dart';
import 'package:dono_here/domain/models/blood_request.dart';
import 'package:dono_here/domain/models/donor_profile.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/auth/presentation/providers/current_user_provider.dart';
import 'package:dono_here/features/donor/presentation/providers/matching_requests_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dono_here/core/providers/repository_providers.dart';
import 'package:dono_here/features/requests/presentation/providers/requests_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

BloodRequest _request({
  required String id,
  String requesterId = 'user-1',
  BloodType bloodType = BloodType.oPositive,
  RequestUrgency urgency = RequestUrgency.medium,
  RequestStatus status = RequestStatus.open,
  DateTime? createdAt,
}) => BloodRequest(
  id: id,
  requesterId: requesterId,
  hospital: 'Test Hospital',
  bloodTypeNeeded: bloodType,
  unitsNeeded: 1,
  latitude: 9.0,
  longitude: 38.7,
  urgency: urgency,
  status: status,
  createdAt: createdAt ?? DateTime.utc(2026, 1, 1),
);

final _donor = DonorProfile(
  id: 'donor-x',
  userId: 'user-9',
  area: 'Bole',
  bloodType: BloodType.oPositive,
  latitude: 9.0,
  longitude: 38.7,
  isAvailable: true,
  isVisible: true,
  updatedAt: DateTime.utc(2026, 1, 1),
);

void main() {
  group('filterRequestsForDonor', () {
    test('keeps only open requests that need the donor blood type', () {
      final result = filterRequestsForDonor(
        requests: [
          _request(id: 'match'),
          _request(id: 'wrong-type', bloodType: BloodType.aPositive),
          _request(id: 'fulfilled', status: RequestStatus.fulfilled),
        ],
        profile: _donor,
        currentUserId: 'user-9',
      );
      expect(result.map((r) => r.id), ['match']);
    });

    test('matching list drops a request once it is fulfilled', () async {
    // user-2 is the seeded O+ donor; request-1 is an open O+ request.
    final container = ProviderContainer(
      overrides: [
        currentRequesterIdProvider.overrideWithValue('user-2'),
        currentUserProvider.overrideWith(
          (ref) => SeedData.sample().users[1],
        ),
      ],
    );
    addTearDown(container.dispose);

    var items = await container.read(matchingRequestsProvider.future);
    expect(items.map((i) => i.request.id), contains('request-1'));

    final repository = container.read(bloodRequestRepositoryProvider);
    final request = (await repository.getRequest('request-1'))!;
    await repository.saveRequest(
      request.copyWith(status: RequestStatus.fulfilled),
    );
    container.invalidate(openRequestsProvider);

    items = await container.read(matchingRequestsProvider.future);
    expect(items.map((i) => i.request.id), isNot(contains('request-1')));
  });

    test('hides the donor own requests', () {
      final result = filterRequestsForDonor(
        requests: [
          _request(id: 'mine', requesterId: 'user-9'),
          _request(id: 'theirs'),
        ],
        profile: _donor,
        currentUserId: 'user-9',
      );
      expect(result.map((r) => r.id), ['theirs']);
    });

    test('puts critical first, then the newest', () {
      final result = filterRequestsForDonor(
        requests: [
          _request(id: 'old-medium', createdAt: DateTime.utc(2026, 1, 1)),
          _request(id: 'new-medium', createdAt: DateTime.utc(2026, 1, 5)),
          _request(id: 'critical', urgency: RequestUrgency.critical),
        ],
        profile: _donor,
        currentUserId: 'user-9',
      );
      expect(result.map((r) => r.id), ['critical', 'new-medium', 'old-medium']);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:dono_here/data/repositories/in_memory_auth_repository.dart';
import 'package:dono_here/data/repositories/in_memory_blood_request_repository.dart';
import 'package:dono_here/data/repositories/in_memory_matching_repository.dart';
import 'package:dono_here/data/repositories/in_memory_store.dart';
import 'package:dono_here/domain/models/blood_request.dart';
import 'package:dono_here/domain/models/donor_profile.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/domain/models/user.dart';

void main() {
  final t0 = DateTime.utc(2026, 1, 1);

  InMemoryStore buildStore() => InMemoryStore(
    users: [
      User(
        id: 'u1',
        fullName: 'Requester',
        email: 'r@example.com',
        phoneNumber: '1',
        role: UserRole.requester,
        createdAt: t0,
      ),
      User(
        id: 'u2',
        fullName: 'Donor',
        email: 'd@example.com',
        phoneNumber: '2',
        role: UserRole.donor,
        createdAt: t0,
      ),
    ],
    donorProfiles: [
      DonorProfile(
        id: 'd1',
        userId: 'u2',
        bloodType: BloodType.oPositive,
        area: 'Bole',
        latitude: 0,
        longitude: 0,
        isAvailable: true,
        isVisible: true,
        updatedAt: t0,
      ),
      DonorProfile(
        id: 'd2',
        userId: 'u2',
        bloodType: BloodType.aPositive,
        area: 'Piassa',
        latitude: 0,
        longitude: 0,
        isAvailable: false,
        isVisible: true,
        updatedAt: t0,
      ),
    ],
    bloodRequests: [
      BloodRequest(
        id: 'r1',
        requesterId: 'u1',
        bloodTypeNeeded: BloodType.oPositive,
        unitsNeeded: 1,
        hospital: 'H',
        latitude: 0,
        longitude: 0,
        urgency: RequestUrgency.critical,
        status: RequestStatus.open,
        createdAt: t0,
      ),
    ],
  );

  test('getRequestsByRequester filters by requesterId, not id', () async {
    final repo = InMemoryBloodRequestRepository(buildStore());

    expect((await repo.getRequestsByRequester('u1')).map((r) => r.id), ['r1']);
    expect(await repo.getRequestsByRequester('nope'), isEmpty);
  });

  test('findDonorsFor matches blood type and availability', () async {
    final store = buildStore();
    final request = store.bloodRequests['r1']!;

    final donors = await InMemoryMatchingRepository(store)
        .findDonorsFor(request);

    expect(donors.map((d) => d.id), ['d1']);
  });

  test('respondToRequest stores a deterministic response', () async {
    final store = buildStore();
    final repo = InMemoryMatchingRepository(store);

    final response = await repo.respondToRequest(
      requestId: 'r1',
      donorId: 'd1',
    );

    expect(response.id, 'response-r1-d1');
    expect(response.status, ResponseStatus.pending);
    expect(await repo.getResponses('r1'), [response]);
  });

  test('signIn sets currentUser and signOut clears it', () async {
    final repo = InMemoryAuthRepository(buildStore());

    expect(await repo.currentUser, isNull);
    expect((await repo.signIn(email: 'd@example.com')).id, 'u2');
    expect((await repo.currentUser)?.id, 'u2');

    await repo.signOut();
    expect(await repo.currentUser, isNull);
  });
}

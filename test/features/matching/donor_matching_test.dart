import 'package:dono_here/data/repositories/in_memory_matching_repository.dart';
import 'package:dono_here/data/repositories/in_memory_store.dart';
import 'package:dono_here/data/seed/seed_data.dart';
import 'package:dono_here/domain/models/blood_request.dart';
import 'package:dono_here/domain/models/donor_profile.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:flutter_test/flutter_test.dart';

BloodRequest requestFor(BloodType bloodType) {
  return BloodRequest(
    id: 'request-test',
    requesterId: 'user-1',
    hospital: 'Tikur Anbessa',
    bloodTypeNeeded: bloodType,
    unitsNeeded: 2,
    latitude: 9.03,
    longitude: 38.74,
    urgency: RequestUrgency.critical,
    status: RequestStatus.open,
    createdAt: DateTime.utc(2026, 1, 1),
  );
}

void main() {
  test('finds only available, visible donors with the requested blood type', () async {
    final seed = SeedData.sample();
    final store = InMemoryStore(
      users: seed.users,
      donorProfiles: [
        ...seed.donorProfiles,
        DonorProfile(
          id: 'donor-3',
          userId: 'user-4',
          area: 'Bole',
          bloodType: BloodType.oPositive,
          latitude: 9.02,
          longitude: 38.75,
          isAvailable: false,
          isVisible: true,
          updatedAt: DateTime.utc(2026, 2, 1),
        ),
      ],
      bloodRequests: seed.bloodRequests,
      responses: seed.responses,
    );
    final repository = InMemoryMatchingRepository(store);

    final oPositive = await repository.findDonorsFor(
      requestFor(BloodType.oPositive),
    );
    expect(oPositive.map((donor) => donor.id), ['donor-1']);

    final aPositive = await repository.findDonorsFor(
      requestFor(BloodType.aPositive),
    );
    expect(aPositive.map((donor) => donor.id), ['donor-2']);
  });

  test('records a pending response for a matching request and donor', () async {
    final seed = SeedData.sample();
    final store = InMemoryStore(
      users: seed.users,
      donorProfiles: seed.donorProfiles,
      bloodRequests: seed.bloodRequests,
      responses: seed.responses,
    );
    final repository = InMemoryMatchingRepository(store);

    final response = await repository.respondToRequest(
      requestId: 'request-1',
      donorId: 'donor-1',
    );

    expect(response.status, ResponseStatus.pending);
    expect(
      (await repository.getResponses('request-1')).map((item) => item.id),
      contains(response.id),
    );
  });
}
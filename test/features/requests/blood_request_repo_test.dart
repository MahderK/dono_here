import 'package:dono_here/data/repositories/in_memory_blood_request_repository.dart';
import 'package:dono_here/data/repositories/in_memory_store.dart';
import 'package:dono_here/data/seed/seed_data.dart';
import 'package:dono_here/domain/models/blood_request.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:flutter_test/flutter_test.dart';

InMemoryBloodRequestRepository repositoryWithSeed() {
  final seed = SeedData.sample();
  return InMemoryBloodRequestRepository(
    InMemoryStore(
      users: seed.users,
      donorProfiles: seed.donorProfiles,
      bloodRequests: seed.bloodRequests,
      responses: seed.responses,
    ),
  );
}

BloodRequest newRequest({required String requesterId}) {
  return BloodRequest(
    id: 'request-test',
    requesterId: requesterId,
    hospital: 'St. Paul Hospital',
    bloodTypeNeeded: BloodType.aNegative,
    unitsNeeded: 3,
    latitude: 9.03,
    longitude: 38.74,
    urgency: RequestUrgency.medium,
    status: RequestStatus.open,
    createdAt: DateTime.utc(2026, 2, 1),
  );
}

void main() {
  test('getOpenRequests returns only open requests', () async {
    final repository = repositoryWithSeed();

    expect((await repository.getOpenRequests()).map((r) => r.id), [
      'request-1',
    ]);
  });

  test('getRequestsByRequester filters by requesterId', () async {
    final repository = repositoryWithSeed();

    expect(
      (await repository.getRequestsByRequester('user-1')).map((r) => r.id),
      ['request-1'],
    );
    expect(
      await repository.getRequestsByRequester('user-2'),
      isEmpty,
    );
  });

  test('saveRequest stores and updates a request', () async {
    final repository = repositoryWithSeed();
    final created = newRequest(requesterId: 'user-2');

    await repository.saveRequest(created);
    expect((await repository.getRequest(created.id))?.hospital, 'St. Paul Hospital');

    await repository.saveRequest(
      created.copyWith(status: RequestStatus.fulfilled),
    );
    expect(
      (await repository.getRequest(created.id))?.status,
      RequestStatus.fulfilled,
    );
    expect((await repository.getOpenRequests()).map((r) => r.id), [
      'request-1',
    ]);
  });
}
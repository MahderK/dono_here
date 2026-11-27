import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dono_here/core/providers/repository_providers.dart';
import 'package:dono_here/data/repositories/in_memory_store.dart';
import 'package:dono_here/domain/models/blood_request.dart';
import 'package:dono_here/domain/models/donor_profile.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/matching/presentation/providers/nearby_donors_providers.dart';

void main() {
  final t0 = DateTime.utc(2026, 1, 1);

  BloodRequest request() => BloodRequest(
    id: 'r1',
    requesterId: 'u1',
    hospital: 'H',
    area: 'Bole',
    bloodTypeNeeded: BloodType.oPositive,
    unitsNeeded: 1,
    latitude: 0,
    longitude: 0,
    urgency: RequestUrgency.medium,
    status: RequestStatus.open,
    createdAt: t0,
  );

  DonorProfile donor({
    required String id,
    required String area,
    required DateTime updatedAt,
    BloodType bloodType = BloodType.oPositive,
    bool isAvailable = true,
    bool isVisible = true,
  }) => DonorProfile(
    id: id,
    userId: 'u-$id',
    area: area,
    bloodType: bloodType,
    latitude: 0,
    longitude: 0,
    isAvailable: isAvailable,
    isVisible: isVisible,
    updatedAt: updatedAt,
  );

  test('sortDonorSuggestions orders available, same area, then recency', () {
    final donors = [
      donor(id: 'unavailable', area: 'Bole', updatedAt: t0, isAvailable: false),
      donor(
        id: 'other-new',
        area: 'Piassa',
        updatedAt: t0.add(const Duration(days: 5)),
      ),
      donor(
        id: 'same-old',
        area: ' bole ',
        updatedAt: t0.add(const Duration(days: 1)),
      ),
      donor(
        id: 'same-new',
        area: 'Bole',
        updatedAt: t0.add(const Duration(days: 3)),
      ),
    ];

    final sorted = sortDonorSuggestions(request(), donors);

    expect(sorted.map((d) => d.id), [
      'same-new',
      'same-old',
      'other-new',
      'unavailable',
    ]);
  });

  test('nearbyDonorsProvider filters and sorts through repositories', () async {
    final container = ProviderContainer(
      overrides: [
        inMemoryStoreProvider.overrideWithValue(
          InMemoryStore(
            bloodRequests: [request()],
            donorProfiles: [
              donor(id: 'd-same', area: 'Bole', updatedAt: t0),
              donor(
                id: 'd-other',
                area: 'Piassa',
                updatedAt: t0.add(const Duration(days: 2)),
              ),
              donor(
                id: 'd-unavailable',
                area: 'Bole',
                updatedAt: t0,
                isAvailable: false,
              ),
              donor(
                id: 'd-invisible',
                area: 'Bole',
                updatedAt: t0,
                isVisible: false,
              ),
              donor(
                id: 'd-wrong-type',
                area: 'Bole',
                updatedAt: t0,
                bloodType: BloodType.aPositive,
              ),
            ],
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(nearbyDonorsProvider('r1').future);

    expect(result, isNotNull);
    expect(result!.request.id, 'r1');
    expect(result.donors.map((d) => d.id), ['d-same', 'd-other']);
  });

  test('nearbyDonorsProvider returns null for an unknown request', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(await container.read(nearbyDonorsProvider('nope').future), isNull);
  });
}

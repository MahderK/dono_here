import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/requests/presentation/providers/requests_providers.dart';

void main() {
  test(
    'createRequest stores an open request owned by the current user',
    () async {
      final container = ProviderContainer(
        overrides: [currentRequesterIdProvider.overrideWithValue('user-1')],
      );
      addTearDown(container.dispose);

      final before = await container.read(myRequestsProvider.future);
      expect(before.map((r) => r.id), ['request-1']);

      final created = await container
          .read(myRequestsProvider.notifier)
          .createRequest(
            bloodType: BloodType.bNegative,
            units: 3,
            hospital: '  St. Paul  ',
            area: 'Bole',
            urgency: RequestUrgency.medium,
          );

      final after = await container.read(myRequestsProvider.future);
      expect(after.length, 2);
      expect(after.first.id, created.id); // newest first
      expect(created.requesterId, 'user-1');
      expect(created.hospital, 'St. Paul');
      expect(created.status, RequestStatus.open);
    },
  );

  test('only lists requests that belong to the signed-in requester', () async {
    final container = ProviderContainer(
      overrides: [currentRequesterIdProvider.overrideWithValue('user-2')],
    );
    addTearDown(container.dispose);

    expect(await container.read(myRequestsProvider.future), isEmpty);
  });
}

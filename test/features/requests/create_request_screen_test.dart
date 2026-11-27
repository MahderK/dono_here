import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/requests/presentation/providers/requests_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer signedInContainer() {
  final container = ProviderContainer(
    overrides: [currentRequesterIdProvider.overrideWithValue('user-1')],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('submitting a request adds it to My Requests and Home', () async {
    final container = signedInContainer();
    await container.read(myRequestsProvider.future);

    final created = await container
        .read(myRequestsProvider.notifier)
        .createRequest(
          bloodType: BloodType.oNegative,
          units: 2,
          hospital: 'St. Paul Hospital',
          urgency: RequestUrgency.critical,
        );

    expect(created.requesterId, 'user-1');
    expect(created.hospital, 'St. Paul Hospital');
    expect(created.status, RequestStatus.open);

    final mine = await container.read(myRequestsProvider.future);
    expect(mine.map((request) => request.id), contains(created.id));

    final open = await container.read(openRequestsProvider.future);
    expect(open.map((request) => request.id), contains(created.id));
  });

  test('a signed-out requester cannot create a request', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await expectLater(
      container.read(myRequestsProvider.notifier).createRequest(
            bloodType: BloodType.oPositive,
            units: 1,
            hospital: 'Tikur Anbessa',
            urgency: RequestUrgency.low,
          ),
      throwsA(isA<StateError>()),
    );
  });
}
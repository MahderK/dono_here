import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/requests/presentation/home_screen.dart';
import 'package:dono_here/features/requests/presentation/providers/requests_providers.dart';
import 'package:dono_here/features/requests/presentation/request_detail_screen.dart';

ProviderScope _scopeFor(String userId, Widget child) {
  return ProviderScope(
    overrides: [currentRequesterIdProvider.overrideWithValue(userId)],
    child: child,
  );
}

void main() {
  test('fulfilling a request removes it from the open requests', () async {
    final container = ProviderContainer(
      overrides: [currentRequesterIdProvider.overrideWithValue('user-1')],
    );
    addTearDown(container.dispose);

    final before = await container.read(openRequestsProvider.future);
    expect(before.map((r) => r.id), contains('request-1'));

    await container.read(myRequestsProvider.notifier).fulfillRequest('request-1');

    final open = await container.read(openRequestsProvider.future);
    expect(open.map((r) => r.id), isNot(contains('request-1')));

    final mine = await container.read(myRequestsProvider.future);
    expect(
      mine.firstWhere((r) => r.id == 'request-1').status,
      RequestStatus.fulfilled,
    );
  });

  test('only the requester can mark a request fulfilled', () async {
    final container = ProviderContainer(
      overrides: [currentRequesterIdProvider.overrideWithValue('user-2')],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(myRequestsProvider.notifier).fulfillRequest('request-1'),
      throwsA(isA<StateError>()),
    );
  });

  test('a newly created request shows up in the open requests', () async {
    final container = ProviderContainer(
      overrides: [currentRequesterIdProvider.overrideWithValue('user-1')],
    );
    addTearDown(container.dispose);

    await container.read(openRequestsProvider.future);
    final created = await container
        .read(myRequestsProvider.notifier)
        .createRequest(
          bloodType: BloodType.aNegative,
          units: 1,
          hospital: 'Black Lion',
          urgency: RequestUrgency.low,
        );

    final open = await container.read(openRequestsProvider.future);
    expect(open.map((r) => r.id), contains(created.id));
  });

  testWidgets('Home lists open requests', (tester) async {
    await tester.pumpWidget(
      _scopeFor('user-1', const MaterialApp(home: HomeScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa'), findsOneWidget);
  });

  testWidgets('detail shows the request and the requester can fulfil it', (
    tester,
  ) async {
    await tester.pumpWidget(
      _scopeFor(
        'user-1',
        const MaterialApp(home: RequestDetailScreen(requestId: 'request-1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa'), findsOneWidget);
    final fulfil = find.text('Mark as fulfilled');
    expect(fulfil, findsOneWidget);

    await tester.ensureVisible(fulfil);
    await tester.tap(fulfil);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('Mark as fulfilled'), findsNothing);
    expect(find.text('Fulfilled'), findsWidgets);
  });

  testWidgets('detail hides the fulfil button from other users', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [currentRequesterIdProvider.overrideWithValue('user-2')],
        child: const MaterialApp(
          home: RequestDetailScreen(requestId: 'request-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa'), findsOneWidget);
    expect(find.text('Mark as fulfilled'), findsNothing);
  });

  testWidgets('detail shows a not-found message for an unknown id', (
    tester,
  ) async {
    await tester.pumpWidget(
      _scopeFor(
        'user-1',
        const MaterialApp(home: RequestDetailScreen(requestId: 'nope')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Request not found'), findsOneWidget);
  });
}

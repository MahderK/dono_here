import 'package:dono_here/app.dart';
import 'package:dono_here/core/router/app_router.dart';
import 'package:dono_here/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DonoHere app boots into sign in when signed out', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: DonoHereApp()));
    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Need an account? Register'), findsOneWidget);
    expect(find.text('Home (Open Requests)'), findsNothing);
  });

  testWidgets('redirect guard sends signed-out deep links to sign in, then home after sign in', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const DonoHereApp(),
      ),
    );
    await tester.pumpAndSettle();

    router.go(AppRoutes.myRequests);
    await tester.pumpAndSettle();

    expect(find.text('Need an account? Register'), findsOneWidget);
    expect(find.text('My Requests'), findsNothing);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'birhanu@example.com',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'password123',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Home (Open Requests)'), findsOneWidget);
    expect(find.text('Need an account? Register'), findsNothing);
  });
}

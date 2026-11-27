import 'package:dono_here/app.dart';
import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';
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

  testWidgets('DonoHere app boots into Home for a signed-in donor', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(authProvider.notifier).signIn(
          email: 'birhanu@example.com',
          password: 'password123',
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const DonoHereApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Home (Open Requests)'), findsOneWidget);
    expect(find.text('Need an account? Register'), findsNothing);
  });
}

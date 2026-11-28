import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';
import 'package:dono_here/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Finder field(String label) {
  return find.byWidgetPredicate(
    (widget) => widget is TextField && widget.decoration?.labelText == label,
  );
}

void main() {
  ProviderContainer createContainer() {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    return container;
  }

  Future<void> pumpSignIn(WidgetTester tester, ProviderContainer container) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: SignInScreen()),
      ),
    );
    await tester.pump();
  }

  testWidgets('shows validation errors for an empty sign in', (tester) async {
    final container = createContainer();
    await pumpSignIn(tester, container);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Enter email'), findsOneWidget);
    expect(
      find.text('Password must be at least 4 characters'),
      findsOneWidget,
    );
  });

  testWidgets('signs in with a seed account', (tester) async {
    final container = createContainer();
    await pumpSignIn(tester, container);

    await tester.enterText(field('Email'), 'birhanu@example.com');
    await tester.enterText(field('Password'), 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(container.read(authProvider).user?.email, 'birhanu@example.com');
    expect(find.text('Incorrect password'), findsNothing);
  });

  testWidgets('shows a wrong-password error from the real auth provider', (
    tester,
  ) async {
    final container = createContainer();
    await pumpSignIn(tester, container);

    await tester.enterText(field('Email'), 'birhanu@example.com');
    await tester.enterText(field('Password'), 'wrong-password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Incorrect password'), findsOneWidget);
    expect(container.read(authProvider).user, isNull);
  });
}
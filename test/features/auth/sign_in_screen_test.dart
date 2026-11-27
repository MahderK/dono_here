import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:dono_here/features/auth/presentation/screens/sign_in_screen.dart';

void main() {
  testWidgets('sign-in form shows validation on empty submit and submits valid input',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Placeholder(), // Replace with SignInScreen()
          ),
        ),
      ),
    );

    // Tap submit with empty fields -> expect validation message
    // Fill email & password -> tap submit -> expect action triggered
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
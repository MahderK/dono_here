import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:dono_here/features/requests/presentation/create_request_screen.dart';
import 'package:dono_here/features/requests/presentation/my_requests_screen.dart';
import 'package:dono_here/features/requests/presentation/providers/requests_providers.dart';

ProviderScope _scopeFor(String userId, Widget child) {
  return ProviderScope(
    overrides: [currentRequesterIdProvider.overrideWithValue(userId)],
    child: child,
  );
}

void main() {
  testWidgets('My Requests lists the current user\'s requests', (tester) async {
    await tester.pumpWidget(
      _scopeFor('user-1', const MaterialApp(home: MyRequestsScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa'), findsOneWidget);
  });

  testWidgets('My Requests shows an empty state when there are none', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [currentRequesterIdProvider.overrideWithValue('user-2')],
        child: const MaterialApp(home: MyRequestsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('No requests yet'), findsOneWidget);
  });

  testWidgets('Create request form validates required fields', (tester) async {
    await tester.pumpWidget(
      _scopeFor('user-1', const MaterialApp(home: CreateRequestScreen())),
    );

    final submit = find.text('Submit request');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Select a blood type'), findsOneWidget);
    expect(find.text('Enter the hospital name'), findsOneWidget);
  });
}

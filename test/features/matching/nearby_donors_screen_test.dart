import 'package:flutter/material.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';
import 'package:dono_here/features/matching/presentation/nearby_donors_screen.dart';
import 'package:dono_here/features/matching/presentation/providers/matching_providers.dart';
import 'package:dono_here/features/requests/presentation/home_screen.dart';
import 'package:dono_here/features/requests/presentation/request_detail_screen.dart';

Future<ProviderContainer> signedInContainer(String email) async {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  await container.read(authProvider.notifier).signIn(
        email: email,
        password: 'password123',
      );
  return container;
}

Widget _screenWith(ProviderContainer container, Widget child) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      localizationsDelegates: const [
        flutter.DefaultMaterialLocalizations.delegate,
      ],
      home: child,
    ),
  );
}

void main() {
  testWidgets('Nearby Donors lists only donors matching the request', (
    tester,
  ) async {
    final container = await signedInContainer('ada@example.com');

    await tester.pumpWidget(
      _screenWith(container, const NearbyDonorsScreen(requestId: 'request-1')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa · O+ · 2 unit(s)'), findsOneWidget);
    expect(find.text('Bole'), findsOneWidget);
    expect(find.text('Piassa'), findsNothing);
  });

  testWidgets('Home shows the matching request to an O+ donor', (
    tester,
  ) async {
    final container = await signedInContainer('birhanu@example.com');

    await tester.pumpWidget(_screenWith(container, const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa'), findsOneWidget);
  });

  testWidgets('Home hides a non-matching request from an A+ donor', (
    tester,
  ) async {
    final container = await signedInContainer('chaltu@example.com');

    await tester.pumpWidget(_screenWith(container, const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa'), findsNothing);
  });

  testWidgets('a donor can respond to a request and sees the flag flip', (
    tester,
  ) async {
    final container = await signedInContainer('birhanu@example.com');

    await tester.pumpWidget(
      _screenWith(
        container,
        const RequestDetailScreen(requestId: 'request-1'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('I can donate'), findsOneWidget);
    await tester.tap(find.text('I can donate'));
    await tester.pumpAndSettle();

    expect(find.text('You responded'), findsOneWidget);
    expect(find.text('1 donor(s) responded'), findsOneWidget);

    final responses = await container.read(
      requestResponsesProvider('request-1').future,
    );
    expect(responses.map((response) => response.donorId), contains('donor-1'));
  });
}

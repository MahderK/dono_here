import 'package:flutter/material.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:dono_here/core/providers/repository_providers.dart';
import 'package:dono_here/data/repositories/in_memory_store.dart';
import 'package:dono_here/domain/models/blood_request.dart';
import 'package:dono_here/domain/models/donor_profile.dart';
import 'package:dono_here/domain/models/enums.dart';
import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';
import 'package:dono_here/features/matching/presentation/nearby_donors_screen.dart';
import 'package:dono_here/features/requests/presentation/home_screen.dart';
import 'package:dono_here/features/requests/presentation/request_detail_screen.dart';

void main() {
  final t0 = DateTime.utc(2026, 1, 1);

  BloodRequest request() => BloodRequest(
    id: 'r1',
    requesterId: 'u1',
    hospital: 'Black Lion',
    area: 'Bole',
    bloodTypeNeeded: BloodType.oPositive,
    unitsNeeded: 1,
    latitude: 0,
    longitude: 0,
    urgency: RequestUrgency.critical,
    status: RequestStatus.open,
    createdAt: t0,
  );

  DonorProfile donor(
    String id,
    String area,
    DateTime updatedAt, {
    bool isAvailable = true,
    BloodType bloodType = BloodType.oPositive,
  }) => DonorProfile(
    id: id,
    userId: 'u-$id',
    area: area,
    bloodType: bloodType,
    latitude: 0,
    longitude: 0,
    isAvailable: isAvailable,
    isVisible: true,
    updatedAt: updatedAt,
  );

  InMemoryStore storeWithDonors() => InMemoryStore(
    bloodRequests: [request()],
    donorProfiles: [
      donor('d-same-old', 'Bole', t0),
      donor('d-same-new', 'Bole', t0.add(const Duration(days: 2))),
      donor('d-far', 'Piassa', t0.add(const Duration(days: 1))),
      donor('d-unavailable', 'Bole', t0, isAvailable: false),
      donor('d-wrong-type', 'Bole', t0, bloodType: BloodType.aPositive),
    ],
  );

  testWidgets('cards are filtered, sorted, and labelled', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [inMemoryStoreProvider.overrideWithValue(storeWithDonors())],
        child: const MaterialApp(home: NearbyDonorsScreen(requestId: 'r1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(3));

    final tiles = tester.widgetList<ListTile>(find.byType(ListTile)).toList();
    final titles = tiles.map((tile) => (tile.title! as Text).data).toList();
    expect(titles, ['Bole', 'Bole', 'Piassa']);

    final subtitles = tiles
        .map((tile) => (tile.subtitle! as Text).data)
        .toList();
    expect(subtitles.first, contains('Last updated'));
    expect(subtitles.first, contains('Available'));

    expect(find.text('Same area'), findsNWidgets(2));
    expect(find.textContaining('Milestone 1'), findsOneWidget);
  });

  testWidgets('seed request shows its matching donor', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: NearbyDonorsScreen(requestId: 'request-1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Bole'), findsOneWidget);
    expect(find.text('O+'), findsOneWidget);
    expect(find.text('Same area'), findsOneWidget);
  });

  testWidgets('shows an empty state when nothing matches', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          inMemoryStoreProvider.overrideWithValue(
            InMemoryStore(bloodRequests: [request()]),
          ),
        ],
        child: const MaterialApp(home: NearbyDonorsScreen(requestId: 'r1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No matching donors right now.'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('shows not-found for an unknown request id', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: NearbyDonorsScreen(requestId: 'nope')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Request not found'), findsOneWidget);
  });

  Future<ProviderContainer> signedInContainer(String email) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(authProvider.notifier).signIn(
          email: email,
          password: 'password123',
        );
    return container;
  }

  Widget screenWith(ProviderContainer container, Widget child) {
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

  testWidgets('signed-in requester sees only donors matching the request', (
    tester,
  ) async {
    final container = await signedInContainer('ada@example.com');

    await tester.pumpWidget(
      screenWith(container, const NearbyDonorsScreen(requestId: 'request-1')),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Tikur Anbessa · O+'), findsOneWidget);
    expect(find.text('Bole'), findsOneWidget);
    expect(find.text('Piassa'), findsNothing);
  });

  testWidgets('Home shows the matching request to an O+ donor', (tester) async {
    final container = await signedInContainer('birhanu@example.com');

    await tester.pumpWidget(screenWith(container, const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa'), findsOneWidget);
  });

  testWidgets('Home hides a non-matching request from an A+ donor', (
    tester,
  ) async {
    final container = await signedInContainer('chaltu@example.com');

    await tester.pumpWidget(screenWith(container, const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Tikur Anbessa'), findsNothing);
  });

  testWidgets('a signed-in donor can respond to a request', (tester) async {
    final container = await signedInContainer('birhanu@example.com');

    await tester.pumpWidget(
      screenWith(container, const RequestDetailScreen(requestId: 'request-1')),
    );
    await tester.pumpAndSettle();

    final respond = find.text('Respond');
    expect(respond, findsOneWidget);

    await tester.tap(respond);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('You already responded to this request.'), findsOneWidget);

    final responses = await container
        .read(matchingRepositoryProvider)
        .getResponses('request-1');
    expect(responses.map((r) => r.donorId), contains('donor-1'));
  });

  testWidgets('requester sees that a donor responded on request detail', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(authProvider.notifier).signIn(
          email: 'birhanu@example.com',
          password: 'password123',
        );
    await container.read(matchingRepositoryProvider).respondToRequest(
          requestId: 'request-1',
          donorId: 'donor-1',
        );
    await container.read(authProvider.notifier).signOut();
    await container.read(authProvider.notifier).signIn(
          email: 'ada@example.com',
          password: 'password123',
        );

    await tester.pumpWidget(
      screenWith(container, const RequestDetailScreen(requestId: 'request-1')),
    );
    await tester.pumpAndSettle();

    expect(find.text('1 donor(s) responded'), findsOneWidget);
  });
}

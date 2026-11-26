import 'package:dono_here/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DonoHere app boots into shell with Home screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: DonoHereApp()));
    await tester.pumpAndSettle();

    expect(find.text('Home (Open Requests)'), findsOneWidget);
    expect(find.text('Donor Profile'), findsOneWidget);
    expect(find.text('My Requests'), findsOneWidget);
  });
}
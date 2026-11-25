import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dono_here/app.dart';

void main() {
  testWidgets('DonoHere app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: DonoHereApp()));

    expect(find.text('DonoHere'), findsOneWidget);
  });
}

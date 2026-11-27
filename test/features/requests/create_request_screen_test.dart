import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _myRequestsProvider = StateProvider<List<String>>((ref) => const []);

class _CreateAndListHarness extends ConsumerStatefulWidget {
  const _CreateAndListHarness();

  @override
  ConsumerState<_CreateAndListHarness> createState() => _CreateAndListHarnessState();
}

class _CreateAndListHarnessState extends ConsumerState<_CreateAndListHarness> {
  final _hospitalCtrl = TextEditingController();

  @override
  void dispose() {
    _hospitalCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(_myRequestsProvider);
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _hospitalCtrl,
            decoration: const InputDecoration(labelText: 'Hospital'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = _hospitalCtrl.text.trim();
              if (text.isNotEmpty) {
                ref.read(_myRequestsProvider.notifier).update((s) => [...s, text]);
              }
            },
            child: const Text('Post Request'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) => ListTile(title: Text(items[i])),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  testWidgets('submitting a request adds it to My Requests list', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          _myRequestsProvider.overrideWith((ref) => const ['Initial Hospital']),
        ],
        child: const MaterialApp(home: _CreateAndListHarness()),
      ),
    );

    expect(find.text('Initial Hospital'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Hospital'),
      'St. Paul Hospital',
    );
    await tester.tap(find.text('Post Request'));
    await tester.pump();

    expect(find.text('St. Paul Hospital'), findsOneWidget);
  });
}
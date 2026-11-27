import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _signedInEmailProvider = StateProvider<String?>((ref) => null);

class _TestSignInForm extends ConsumerStatefulWidget {
  const _TestSignInForm();

  @override
  ConsumerState<_TestSignInForm> createState() => _TestSignInFormState();
}

class _TestSignInFormState extends ConsumerState<_TestSignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref.read(_signedInEmailProvider.notifier).state = _emailCtrl.text.trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    final signedInEmail = ref.watch(_signedInEmailProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    (v == null || !v.contains('@')) ? 'Invalid email' : null,
              ),
              TextFormField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (v) =>
                    (v == null || v.length < 4) ? 'Password too short' : null,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Sign In'),
              ),
              if (signedInEmail != null) Text('Signed in: $signedInEmail'),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('validates invalid input and updates state on valid sign-in',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: _TestSignInForm()),
      ),
    );

    await tester.tap(find.text('Sign In'));
    await tester.pump();
    expect(find.text('Invalid email'), findsOneWidget);
    expect(find.text('Password too short'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'user@test.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), '1234');
    await tester.tap(find.text('Sign In'));
    await tester.pump();

    expect(find.text('Invalid email'), findsNothing);
    expect(find.text('Signed in: user@test.com'), findsOneWidget);
  });
}
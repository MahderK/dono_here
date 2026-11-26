import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In / Register')),
      body: Center(
        child: FilledButton(
          onPressed: () => context.go(AppRoutes.home),
          child: const Text('Continue to Home'),
        ),
      ),
    );
  }
}
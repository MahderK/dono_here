import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Open Requests)'),
        actions: [
          TextButton(
            onPressed: () => context.go(AppRoutes.signIn),
            child: const Text('Sign In'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () => context.push(AppRoutes.createRequest),
              child: const Text('Create Request'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () =>
                  context.push(AppRoutes.requestDetailPath('req-101')),
              child: const Text('Open Sample Request (req-101)'),
            ),
          ],
        ),
      ),
    );
  }
}
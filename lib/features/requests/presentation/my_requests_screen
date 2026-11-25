import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Requests')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () => context.push(AppRoutes.createRequest),
              child: const Text('New Request'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () =>
                  context.push(AppRoutes.requestDetailPath('req-202')),
              child: const Text('View Request (req-202)'),
            ),
          ],
        ),
      ),
    );
  }
}
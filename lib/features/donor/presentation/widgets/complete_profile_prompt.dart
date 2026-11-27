import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';

/// "Complete your donor profile" card with a button to the Profile tab.
class CompleteProfilePrompt extends StatelessWidget {
  const CompleteProfilePrompt({
    super.key,
    this.message =
        'Complete your donor profile to see the requests that match your blood type.',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bloodtype_outlined),
                const SizedBox(width: 12),
                Expanded(child: Text(message)),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () => context.go(AppRoutes.profile),
                child: const Text('Complete profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

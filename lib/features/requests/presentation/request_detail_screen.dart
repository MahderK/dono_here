import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';

class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request Detail #$requestId')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Viewing blood request ID: $requestId'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () =>
                  context.push(AppRoutes.nearbyDonorsPath(requestId)),
              child: const Text('View Nearby Donors'),
            ),
          ],
        ),
      ),
    );
  }
}
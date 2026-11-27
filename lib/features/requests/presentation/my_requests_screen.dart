import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../../core/utils/enum_labels.dart';
import 'providers/requests_providers.dart';

class MyRequestsScreen extends ConsumerWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(myRequestsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Requests')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.createRequest),
        icon: const Icon(Icons.add),
        label: const Text('New Request'),
      ),
      body: requests.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Could not load your requests: $error')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No requests yet. Tap "New Request" to ask for blood.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final request = items[index];
              return Card(
                child: ListTile(
                  title: Text(request.hospital),
                  subtitle: Text(
                    '${request.bloodTypeNeeded.label} • '
                    '${request.unitsNeeded} unit(s) • '
                    '${request.urgency.label}',
                  ),
                  trailing: Chip(label: Text(request.status.label)),
                  onTap: () =>
                      context.push(AppRoutes.requestDetailPath(request.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

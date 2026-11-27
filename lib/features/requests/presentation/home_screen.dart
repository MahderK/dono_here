import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../../core/utils/enum_labels.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../../auth/presentation/providers/current_user_provider.dart';
import '../../matching/presentation/providers/matching_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(visibleOpenRequestsProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Open Requests)'),
        actions: [
          if (user != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: Text(user.fullName),
            ),
            TextButton(
              onPressed: () => ref.read(authProvider.notifier).signOut(),
              child: const Text('Sign Out'),
            ),
          ] else
            TextButton(
              onPressed: () => context.go(AppRoutes.signIn),
              child: const Text('Sign In'),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.createRequest),
        icon: const Icon(Icons.add),
        label: const Text('Create Request'),
      ),
      body: requests.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Could not load requests: $error')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No open requests right now.',
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
                    '${request.unitsNeeded} unit(s)',
                  ),
                  trailing: Chip(label: Text(request.urgency.label)),
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../../auth/presentation/providers/current_user_provider.dart';
import '../../donor/presentation/widgets/matching_requests_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      // Donor side: open requests that match the donor's blood type, or a
      // "complete your profile" prompt when the donor has no profile yet.
      body: const MatchingRequestsView(),
    );
  }
}

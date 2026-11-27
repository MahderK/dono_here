import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../donor/presentation/widgets/matching_requests_view.dart';

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

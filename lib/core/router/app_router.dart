import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_shell.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/donor/presentation/donor_profile_screen.dart';
import '../../features/matching/presentation/nearby_donors_screen.dart';
import '../../features/requests/presentation/create_request_screen.dart';
import '../../features/requests/presentation/home_screen.dart';
import '../../features/requests/presentation/my_requests_screen.dart';
import '../../features/requests/presentation/request_detail_screen.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const DonorProfileScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.myRequests,
                builder: (context, state) => const MyRequestsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.createRequest,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CreateRequestScreen(),
      ),
      GoRoute(
        path: AppRoutes.requestDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return RequestDetailScreen(requestId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.nearbyDonors,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return NearbyDonorsScreen(requestId: id);
        },
      ),
    ],
  );
});
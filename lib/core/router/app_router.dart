import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';
import 'package:dono_here/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:dono_here/features/donor/presentation/donor_profile_screen.dart';
import 'package:dono_here/features/matching/presentation/nearby_donors_screen.dart';
import 'package:dono_here/features/requests/presentation/create_request_screen.dart';
import 'package:dono_here/features/requests/presentation/home_screen.dart';
import 'package:dono_here/features/requests/presentation/my_requests_screen.dart';
import 'package:dono_here/features/requests/presentation/request_detail_screen.dart';

import '../widgets/app_shell.dart';
import 'routes.dart';

final authRedirectRefreshProvider = Provider<ValueNotifier<int>>((ref) {
  final notifier = ValueNotifier<int>(0);
  ref.onDispose(notifier.dispose);
  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ref.watch(authRedirectRefreshProvider);
  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  ref.listen(authProvider, (previous, next) {
    refresh.value++;
  });

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    refreshListenable: refresh,
    redirect: (context, state) {
      final isLoggedIn = ref.read(authProvider).user != null;
      final isOnSignIn = state.matchedLocation == AppRoutes.signIn;

      if (!isLoggedIn && !isOnSignIn) {
        return AppRoutes.signIn;
      }
      if (isLoggedIn && isOnSignIn) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
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
        parentNavigatorKey: rootNavigatorKey,
        path: AppRoutes.createRequest,
        builder: (context, state) => const CreateRequestScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRoutes.requestDetail,
        builder: (context, state) {
          return RequestDetailScreen(
            requestId: state.pathParameters['id'] ?? '',
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRoutes.nearbyDonors,
        builder: (context, state) {
          return NearbyDonorsScreen(
            requestId: state.pathParameters['id'] ?? '',
          );
        },
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
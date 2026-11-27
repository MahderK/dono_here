import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dono_here/features/auth/presentation/providers/auth_provider.dart';
import 'package:dono_here/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:dono_here/features/donor/presentation/screens/donor_profile_screen.dart';
import 'package:dono_here/features/matching/presentation/screens/nearby_donors_screen.dart';
import 'package:dono_here/features/requests/presentation/screens/create_request_screen.dart';
import 'package:dono_here/features/requests/presentation/screens/home_screen.dart';
import 'package:dono_here/features/requests/presentation/screens/my_requests_screen.dart';
import 'package:dono_here/features/requests/presentation/screens/request_detail_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouterProvider = Provider<GoRouter>((ref) {
  // Watching authState makes GoRouter re-evaluate redirect when user signs in/out.
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = authState.user != null;
      final isOnSignIn = state.matchedLocation == '/sign-in';

      if (!isLoggedIn && !isOnSignIn) {
        return '/sign-in';
      }
      if (isLoggedIn && isOnSignIn) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _AppShellScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const DonorProfileScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/my-requests',
                builder: (context, state) => const MyRequestsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/requests/new',
        builder: (context, state) => const CreateRequestScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/requests/:id',
        builder: (context, state) {
          final requestId = state.pathParameters['id'] ?? '';
          return RequestDetailScreen(requestId: requestId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/requests/:id/donors',
        builder: (context, state) {
          final requestId = state.pathParameters['id'] ?? '';
          return NearbyDonorsScreen(requestId: requestId);
        },
      ),
    ],
  );
});

class _AppShellScaffold extends StatelessWidget {
  const _AppShellScaffold({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Donor Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'My Requests',
          ),
        ],
      ),
    );
  }
}
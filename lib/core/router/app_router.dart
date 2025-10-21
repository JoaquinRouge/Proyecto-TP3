import 'package:go_router/go_router.dart';
import 'package:proyecto_tp3/presentation/screens/home_screen.dart';
import 'package:proyecto_tp3/presentation/screens/library_screen.dart';
import 'package:proyecto_tp3/presentation/screens/login_screen.dart';
import 'package:proyecto_tp3/presentation/screens/profile_screen.dart';
import 'package:proyecto_tp3/presentation/screens/register_screen.dart';
import 'package:proyecto_tp3/presentation/screens/search_screen.dart';
import 'package:proyecto_tp3/presentation/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        // obtengo el id si viene, sino null
      final id = state.uri.queryParameters['id']; 
      return NoTransitionPage(child: HomeScreen(id: id));
      }
    ),
    GoRoute(
      path: '/library',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: LibraryScreen()),
    ),
    GoRoute(
      path: '/search',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SearchScreen()),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: ProfileScreen()),
    ),
    GoRoute(
      path: '/edit_profile',
      pageBuilder: (context, state) => 
          const NoTransitionPage(child: EditProfileScreen()),
    ),
  ],
  redirect: (context, state) {
    //handleo de deep links
    final uri = Uri.tryParse(state.uri.toString());

    if (uri != null) {
      if (uri.scheme == 'gameshelf') {
        if (uri.host == 'game' && uri.pathSegments.isNotEmpty) {
          final id = uri.pathSegments.first;
          return '/home?id=$id';
        } else if (uri.host == 'profile') {
          return '/profile';
        } else {
          return '/';
        }
      }
    }

    return null; // no hacer redirect
  },
);
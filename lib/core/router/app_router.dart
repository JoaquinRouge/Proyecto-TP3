import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tp3/presentation/screens/home_screen.dart';
import 'package:proyecto_tp3/presentation/screens/library_screen.dart';
import 'package:proyecto_tp3/presentation/screens/login_screen.dart';
import 'package:proyecto_tp3/presentation/screens/profile_screen.dart';
import 'package:proyecto_tp3/presentation/screens/register_screen.dart';
import 'package:proyecto_tp3/presentation/screens/search_screen.dart';
import 'package:proyecto_tp3/presentation/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_tp3/presentation/screens/user_reviews.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>();

final FirebaseAuth _auth = FirebaseAuth.instance;

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
    GoRoute(
      path: '/user_reviews',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: UserReviews()),
    ),
  ],
  redirect: (context, state) {

    if(_auth.currentUser == null) {
      debugPrint('no user logged in, redirecting to login');
      return '/login';
    }

    final uri = Uri.tryParse(state.uri.toString());
    debugPrint('🔗 URI parseado: $uri');
    if (uri != null) {
      if (uri.scheme == 'gameshelf' || uri.scheme == 'https') {
        debugPrint('https y gameshelf scheme detected');
        if (uri.path == '/game' || uri.host == 'game') {
          debugPrint('current user: ${_auth.currentUser}');
          
          debugPrint('path: ${uri.path}');
          final id = uri.queryParameters['id'];
          debugPrint('game id detected: $id');
          if (id != null) return '/home?id=$id';
      } else if (uri.path == '/profile') {
        return '/profile';
      } else {
        return '/';
      }
    }
  }
  return null;
},
);
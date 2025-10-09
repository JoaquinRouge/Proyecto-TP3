import 'package:go_router/go_router.dart';
import 'package:proyecto_tp3/presentation/screens/add_game_screen.dart';
import 'package:proyecto_tp3/presentation/screens/home_screen.dart';
import 'package:proyecto_tp3/presentation/screens/library_screen.dart';
import 'package:proyecto_tp3/presentation/screens/login_screen.dart';
import 'package:proyecto_tp3/presentation/screens/profile_screen.dart';
import 'package:proyecto_tp3/presentation/screens/register_screen.dart';
import 'package:proyecto_tp3/presentation/screens/search_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
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
      path: '/add_game',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: AgregarJuegoPage()),
    ),
  ],
);
// GoRoute

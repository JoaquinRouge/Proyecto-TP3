import 'package:go_router/go_router.dart';
import 'package:proyecto_tp3/presentation/screens/login_screen.dart';
import 'package:proyecto_tp3/presentation/screens/register_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path:'/register', 
      builder: (context, state) {
      return RegisterScreen(); // Cambiar por RegisterScreen() cuando esté implementado
    })
  ],
); // GoRoute

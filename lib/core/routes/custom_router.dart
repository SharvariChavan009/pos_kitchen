
import 'package:go_router/go_router.dart';
import 'package:kitchen_task/core/features/auth/presentation/login_screen.dart';
import 'package:kitchen_task/core/features/auth/presentation/signup_screen.dart';
import 'package:kitchen_task/core/features/splash_screen/splash_screen.dart';

GoRouter customRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignupScreen(), // Pass the global key here
    ),
  ],
);

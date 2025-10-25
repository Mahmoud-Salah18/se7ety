import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/splash/splash_screen.dart';
import 'package:se7ety/features/welcome/welcome_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = "/splash";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String main = "/main";

  static GoRouter routes = GoRouter(
    //initialLocation: splash,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../view/screens/intro_screen.dart';
import '../../view/screens/login_screen.dart';
import '../../view/screens/signup_screen.dart';
import 'route_names.dart';

class AppRoutesConfiguration {
  static GoRouter router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: sharedPreferences!.getBool("skipIntro") == true
        ? "/${AppRouteNames.login}"
        : "/${AppRouteNames.introduction}",
    routes: routes,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          state.error!.message,
        ),
      ),
    ),
  );
  static List<GoRoute> routes = [
    GoRoute(
      path: '/${AppRouteNames.introduction}',
      name: AppRouteNames.introduction,
      builder: (context, state) => const IntroductionScreen(),
    ),
    GoRoute(
      path: '/${AppRouteNames.login}',
      name: AppRouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/${AppRouteNames.signup}',
      name: AppRouteNames.signup,
      builder: (context, state) => const SignupScreen(),
    ),
  ];
}

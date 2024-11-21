import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/page/home_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyRouter {
  static const homeRoute = '/home';
  static const articleRoute = '/article';

  late final router = GoRouter(
    initialLocation: homeRoute,
    navigatorKey: navigatorKey,
    routes: <GoRoute>[
      GoRoute(
        path: homeRoute,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: _build(const HomeScreen()),
        ),
      ),
      // GoRoute(
      //   path: profileRoute,
      //   pageBuilder: (context, state) => buildPageWithDefaultTransition(
      //     context: context,
      //     state: state,
      //     child: _build(const ProfileScreen()),
      //   ),
      // ),
    ],
  );
  Widget _build(Widget child) {
    return Scaffold(body: child);
  }
}

CustomTransitionPage<void> buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
    transitionDuration: const Duration(milliseconds: 300),
  );
}

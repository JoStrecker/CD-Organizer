import 'package:cd_organizer/core/route_info.dart';
import 'package:cd_organizer/ui/dashboard_screen.dart';
import 'package:cd_organizer/ui/detail_screen.dart';
import 'package:cd_organizer/ui/error_screen.dart';
import 'package:cd_organizer/ui/framework.dart';
import 'package:cd_organizer/ui/result_screen.dart';
import 'package:cd_organizer/ui/scanner_screen.dart';
import 'package:cd_organizer/ui/settings_screen.dart';
import 'package:cd_organizer/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CDOrganizerRouter {
  static GoRouter? _router;

  static GoRouter getRouter() {
    _router ??= GoRouter(
      initialLocation: RouteInfo.collection.route,
      routes: [
        ShellRoute(
          pageBuilder: (context, state, child) => MaterialPage<void>(
            key: state.pageKey,
            child: Framework(child: child),
          ),
          routes: [
            GoRoute(
              name: RouteInfo.collection.name,
              path: RouteInfo.collection.route,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                state: state,
                context: context,
                child: const DashboardScreen(),
              ),
            ),
            GoRoute(
              name: RouteInfo.settings.name,
              path: RouteInfo.settings.route,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                state: state,
                context: context,
                child: const SettingsScreen(),
              ),
            ),
            GoRoute(
              name: RouteInfo.scanner.name,
              path: RouteInfo.scanner.route,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                state: state,
                context: context,
                child: const ScannerScreen(),
              ),
            ),
            GoRoute(
              name: RouteInfo.details.name,
              path: RouteInfo.details.route,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                state: state,
                context: context,
                child: const DetailScreen(),
              ),
            ),
            GoRoute(
              name: RouteInfo.results.name,
              path: RouteInfo.results.route,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                state: state,
                context: context,
                child: const ResultScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          name: RouteInfo.splash.name,
          path: RouteInfo.splash.route,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            state: state,
            context: context,
            child: const SplashScreen(),
          ),
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: ErrorScreen(error: state.error),
      ),
    );
    return _router!;
  }

  static CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return NoTransitionPage<T>(
      key: state.pageKey,
      child: child,
    );
  }
}

import 'package:cd_organizer/core/route_info.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/dashboard/ui/dashboard_screen.dart';
import 'package:cd_organizer/feature/details/ui/detail_screen.dart';
import 'package:cd_organizer/feature/error/ui/error_screen.dart';
import 'package:cd_organizer/feature/framework/ui/framework.dart';
import 'package:cd_organizer/feature/scanner/ui/scanner_screen.dart';
import 'package:cd_organizer/feature/settings/ui/settings_screen.dart';
import 'package:cd_organizer/feature/splash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CDOrganizerRouter {
  static GoRouter? _router;
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter getRouter() {
    _router ??= GoRouter(
      initialLocation: RouteInfo.collection.route,
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => Framework(child: child),
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
              routes: [
                GoRoute(
                  name: RouteInfo.details.name,
                  path: RouteInfo.details.route,
                  builder: (context, state) =>
                      DetailScreen(album: state.extra as Album),
                ),
              ],
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

import 'package:music_collection/core/route_info.dart';
import 'package:music_collection/feature/dashboard/ui/dashboard_screen.dart';
import 'package:music_collection/feature/details/ui/detail_screen.dart';
import 'package:music_collection/feature/error/ui/error_screen.dart';
import 'package:music_collection/feature/framework/ui/framework.dart';
import 'package:music_collection/feature/scanner/ui/scanner_screen.dart';
import 'package:music_collection/feature/settings/ui/settings_screen.dart';
import 'package:music_collection/feature/splash/ui/splash_screen.dart';
import 'package:music_collection/feature/wishlist/ui/wishlist_screen.dart';
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
                  pageBuilder: (context, state) => buildPageWithTransition(
                    context: context,
                    state: state,
                    child: DetailScreen(id: state.pathParameters['id']!),
                  ),
                ),
                GoRoute(
                  name: RouteInfo.scanner.name,
                  path: RouteInfo.scanner.route,
                  pageBuilder: (context, state) =>
                      buildPageWithTransition<void>(
                    state: state,
                    context: context,
                    child: const ScannerScreen(wishlist: false),
                  ),
                ),
              ],
            ),
            GoRoute(
              name: RouteInfo.wishlist.name,
              path: RouteInfo.wishlist.route,
              pageBuilder: (context, state) =>
                  buildPageWithDefaultTransition<void>(
                state: state,
                context: context,
                child: const WishlistScreen(),
              ),
              routes: [
                GoRoute(
                  name: RouteInfo.wishDetails.name,
                  path: RouteInfo.wishDetails.route,
                  pageBuilder: (context, state) => buildPageWithTransition(
                    context: context,
                    state: state,
                    child: DetailScreen(id: state.pathParameters['id']!),
                  ),
                ),
                GoRoute(
                  name: RouteInfo.wishScanner.name,
                  path: RouteInfo.wishScanner.route,
                  pageBuilder: (context, state) =>
                      buildPageWithTransition<void>(
                        state: state,
                        context: context,
                        child: const ScannerScreen(wishlist: true),
                      ),
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

  static CustomTransitionPage buildPageWithTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          ScaleTransition(
              scale: animation, alignment: Alignment.topCenter, child: child),
    );
  }
}

import 'package:flutter/material.dart';

/// Describes the possible routes for the main Navigation
class RouteInfo {
  /// Defines the route that is displayed in the url
  final String route;

  /// Defines the name that is used to navigate in the router
  final String name;

  /// Defines the icon that is displayed in the navigation rail
  final IconData icon;

  /// Defines if the route is displayed in the navigation rail ...
  final bool isNavigationRoute;

  RouteInfo._({
    required this.route,
    required this.name,
    required this.icon,
    this.isNavigationRoute = false,
  });

  static List<RouteInfo> get routes => [
    dashboard,
    settings,
    scanner,
    details,
    results,
    search,
    error,
  ];

  static RouteInfo getRouteInfoByRoute(String? route) {
    if (route == null) {
      return error;
    }
    return routes.firstWhere(
          (pageInfo) => route.contains(pageInfo.route),
    );
  }

  static RouteInfo getRouteInfoByName(String? route) {
    if (route == null) {
      return error;
    }
    return routes.firstWhere(
          (pageInfo) => route.contains(pageInfo.name),
    );
  }

  static List<RouteInfo> getNavRoutes() =>
      routes.where((r) => r.isNavigationRoute).toList();

  static List<String> getNavRouteNames() =>
      routes.where((r) => r.isNavigationRoute).map((e) => e.name).toList();

  // Definition of the routes for the navigation
  static RouteInfo dashboard = RouteInfo._(
    route: '/dashboard',
    name: "dashboard",
    icon: Icons.home_filled,
    isNavigationRoute: true,
  );

  static RouteInfo settings = RouteInfo._(
    route: '/settings',
    name: "settings",
    icon: Icons.settings,
    isNavigationRoute: true,
  );

  static RouteInfo scanner = RouteInfo._(
    route: '/scanner',
    name: "scanner",
    icon: Icons.qr_code_scanner,
    isNavigationRoute: true,
  );

  static RouteInfo details = RouteInfo._(
    route: '/details',
    name: "details",
    icon: Icons.album,
    isNavigationRoute: true,
  );

  static RouteInfo results = RouteInfo._(
    route: '/results',
    name: "results",
    icon: Icons.info,
  );

  static RouteInfo search = RouteInfo._(
    route: '/search',
    name: "search",
    icon: Icons.search_rounded,
  );

  static RouteInfo splash = RouteInfo._(
    route: '/splash',
    name: "splash",
    icon: Icons.supervised_user_circle_rounded,
  );

  static RouteInfo error = RouteInfo._(
    route: '/report',
    name: "report",
    icon: Icons.report,
  );
}

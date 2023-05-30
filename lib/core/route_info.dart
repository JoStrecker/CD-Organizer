import 'package:flutter/material.dart';

/// Describes the possible routes for the main Navigation
class RouteInfo {
  /// Defines the route that is displayed in the url
  final String route;

  /// Defines the name that is used to navigate in the router
  final String name;

  /// Defines the icon that is displayed in the navbar
  final IconData icon;

  /// Defines the selected icon that is displayed in the navbar
  final IconData? selectedIcon;

  /// Defines if the route is displayed in the navbar
  final bool isNavigationRoute;

  RouteInfo._({
    required this.route,
    required this.name,
    required this.icon,
    this.selectedIcon,
    this.isNavigationRoute = false,
  });

  static List<RouteInfo> get routes => [
        collection,
        wishlist,
        scanner,
        settings,
        details,
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
  static RouteInfo collection = RouteInfo._(
    route: '/collection',
    name: 'collection',
    icon: Icons.album_outlined,
    selectedIcon: Icons.album,
    isNavigationRoute: true,
  );

  static RouteInfo wishlist = RouteInfo._(
    route: '/wishlist',
    name: 'wishlist',
    icon: Icons.bookmark_outline,
    selectedIcon: Icons.bookmark,
    isNavigationRoute: true,
  );

  static RouteInfo settings = RouteInfo._(
    route: '/settings',
    name: 'settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    isNavigationRoute: true,
  );

  static RouteInfo scanner = RouteInfo._(
    route: 'scanner',
    name: 'scanner',
    icon: Icons.qr_code_scanner,
  );

  static RouteInfo details = RouteInfo._(
    route: 'details/:id',
    name: 'details',
    icon: Icons.album,
  );

  static RouteInfo wishScanner = RouteInfo._(
    route: 'wishScanner',
    name: 'wishScanner',
    icon: Icons.qr_code_scanner,
  );

  static RouteInfo wishDetails = RouteInfo._(
    route: 'wishDetails/:id',
    name: 'wishDetails',
    icon: Icons.album,
  );

  static RouteInfo barcodeReader = RouteInfo._(
    route: 'barcodeReader',
    name: 'barcodeReader',
    icon: Icons.qr_code_scanner,
  );

  static RouteInfo wishBarcodeReader = RouteInfo._(
    route: 'wishBarcodeReader',
    name: 'wishBarcodeReader',
    icon: Icons.qr_code_scanner,
  );

  static RouteInfo splash = RouteInfo._(
    route: '/splash',
    name: 'splash',
    icon: Icons.supervised_user_circle_rounded,
  );

  static RouteInfo error = RouteInfo._(
    route: '/report',
    name: 'report',
    icon: Icons.report,
  );
}

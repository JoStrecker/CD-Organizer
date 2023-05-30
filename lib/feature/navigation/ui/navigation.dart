import 'package:music_collection/core/route_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<RouteInfo> routeInfos = RouteInfo.getNavRoutes();
    String currRoute =
        Router.of(context).routeInformationProvider?.value.location ??
            '/collection';

    return NavigationBar(
        selectedIndex: currRoute.startsWith(RouteInfo.getNavRoutes()[0].route)
            ? 0
            : currRoute.startsWith(RouteInfo.getNavRoutes()[1].route)
                ? 1
                : currRoute.startsWith(RouteInfo.getNavRoutes()[2].route)
                    ? 2
                    : 0,
        destinations: List.generate(
          routeInfos.length,
          (index) => NavigationDestination(
            icon: Icon(routeInfos[index].icon),
            selectedIcon:
                Icon(routeInfos[index].selectedIcon ?? routeInfos[index].icon),
            label: routeInfos[index].name.tr(),
          ),
        ),
        onDestinationSelected: (index) {
          if (currRoute != routeInfos[index].route) {
            context.go(routeInfos[index].route);
          }
        });
  }
}

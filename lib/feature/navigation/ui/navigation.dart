import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_collection/core/route_info.dart';

class Navigation extends StatefulWidget {
  const Navigation({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<RouteInfo> routeInfos = RouteInfo.getNavRoutes();
    return NavigationBar(
        selectedIndex: currIndex,
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
          if (RouteInfo.getNavRoutes()[currIndex] != routeInfos[index]) {
            context.go(routeInfos[index].route);
            setState(() {
              currIndex = RouteInfo.getNavRoutes().indexOf(routeInfos[index]);
            });
          }
        });
  }
}

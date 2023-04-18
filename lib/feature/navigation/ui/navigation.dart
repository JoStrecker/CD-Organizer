import 'package:cd_organizer/core/route_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RouteInfo> routeInfos = RouteInfo.getNavRoutes();
    String currRoute =
        Router.of(context).routeInformationProvider?.value.location ??
            '/collection';
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).colorScheme.onSurface,
      selectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSecondaryContainer),
      backgroundColor: Theme.of(context).colorScheme.surface,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      unselectedIconTheme:
          IconThemeData(color: Theme.of(context).colorScheme.onSurfaceVariant),
      showUnselectedLabels: true,
      currentIndex: currRoute.startsWith('/collection')
          ? 0
          : currRoute.startsWith('/scanner')
              ? 1
              : currRoute.startsWith('/settings')
                  ? 2
                  : 0,
      items: List.generate(
        routeInfos.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(routeInfos[index].icon),
          label: routeInfos[index].name.tr(),
        ),
      ),
      onTap: (index) {
        if (currRoute != routeInfos[index].route) {
          context.go(routeInfos[index].route);
        }
      },
    );
  }
}

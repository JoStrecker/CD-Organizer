import 'package:cd_organizer/core/route_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RouteInfo> routeInfos = RouteInfo.getNavRoutes();
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).colorScheme.onSurface,
      selectedIconTheme:
          IconThemeData(color: Theme.of(context).colorScheme.onSecondaryContainer),
      backgroundColor: Theme.of(context).colorScheme.surface,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurfaceVariant),
      showUnselectedLabels: true,
      currentIndex: routeInfos.indexWhere((element) =>
          element.route ==
          Router.of(context).routeInformationProvider?.value.location),
      items: List.generate(
        routeInfos.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(routeInfos[index].icon),
          label: routeInfos[index].name.tr(),
        ),
      ),
      onTap: (index) {
        context.go(routeInfos[index].route);
      },
    );
  }
}

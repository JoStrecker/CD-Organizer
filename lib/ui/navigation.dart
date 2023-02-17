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
      selectedItemColor: Theme.of(context).colorScheme.primary,
      selectedIconTheme:
          IconThemeData(color: Theme.of(context).colorScheme.primary),
      backgroundColor: Theme.of(context).colorScheme.background,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
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

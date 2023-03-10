import 'package:cd_organizer/core/router.dart';
import 'package:cd_organizer/core/ui/dismiss_keyboard.dart';
import 'package:cd_organizer/core/ui/themes/dark_theme.dart';
import 'package:cd_organizer/core/ui/themes/light_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final router = CDOrganizerRouter.getRouter();
    return DismissKeyboard(
        child: MaterialApp.router(
          title: 'CD Organizer',
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: ThemeMode.system,
          theme: getLightTheme(),
          darkTheme: getDarkTheme(),
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        )
    );
  }
}

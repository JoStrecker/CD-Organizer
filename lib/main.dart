import 'package:cd_organizer/core/app_widget.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  //Current this method is not necessary
  WidgetsFlutterBinding.ensureInitialized();

  //Deactivate that GoogleFonts downloads fonts from the web
  GoogleFonts.config.allowRuntimeFetching = false;

  //Initialize json files for translations
  //Tip: Currently with await but should be in the Splashscreen
  await EasyLocalization.ensureInitialized();

  //Initialize objects for dependency injection
  initInjection();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('de', 'DE'),
        Locale('en', 'US'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('de', 'DE'),
      useOnlyLangCode: true,
      child: const AppWidget(),
    )
  );
}

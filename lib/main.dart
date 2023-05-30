import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:music_collection/core/ui/app_widget.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/albums/domain/track.dart';
import 'package:music_collection/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Deactivate that GoogleFonts downloads fonts from the web
  GoogleFonts.config.allowRuntimeFetching = false;

  //Initialize json files for translations
  await EasyLocalization.ensureInitialized();

  //Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(TrackAdapter());

  //Initialize Firebase Auth and Cloud Store
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Get Color Palette on Android >12 for a Dynamic Color Scheme
  CorePalette? palette = await DynamicColorPlugin.getCorePalette();

  //Get SharedPreferences for saved color
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Color? prefColor = (prefs.getInt('prefColor') != null)
      ? Color(prefs.getInt('prefColor')!)
      : null;

  //Initialize objects for dependency injection
  initInjection();

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('de', 'DE'),
      Locale('en', 'US'),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('de', 'DE'),
    useOnlyLangCode: true,
    child: AppWidget(
      palette: palette,
      prefColor: prefColor,
    ),
  ));
}

import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:music_collection/core/application/global_vars.dart';
import 'package:music_collection/core/ui/app_widget.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/albums/domain/track.dart';
import 'package:music_collection/feature/notifications/domain/received_notification.dart';
import 'package:music_collection/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

//Notification Setup
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel(notificationChannelId);

const String portName = 'notification_send_port';

const String darwinNotificationCategoryPlain = 'plainCategory';

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

  //Initialize Notifications
  await _configureLocalTimeZone();

  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: const AndroidInitializationSettings('ic_launcher_monochrome'),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationStream.add(
            ReceivedNotification(
              id: id,
              title: title,
              body: body,
              payload: payload,
            ),
          );
        },
        notificationCategories: [
          const DarwinNotificationCategory(
            darwinNotificationCategoryPlain,
            actions: <DarwinNotificationAction>[],
            options: <DarwinNotificationCategoryOption>{
              DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
            },
          ),
        ],
      ),
    ),
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

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

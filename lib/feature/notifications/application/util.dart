import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:music_collection/core/application/global_vars.dart';
import 'package:music_collection/main.dart';
import 'package:timezone/timezone.dart' as tz;

Future<bool?> requestNotificationPermissions() async {
  if (Platform.isIOS) {
    return flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  } else if (Platform.isAndroid) {
    return flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
  return false;
}

Future<void> showNotificationWithActions({
  required String title,
  required String text,
  required int id,
}) async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    notificationChannelId,
    notificationChannelName,
    channelDescription: notificationChannelDescription,
    importance: Importance.max,
    priority: Priority.high,
    ticker: title,
  );
  const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );

  flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    text,
    tz.TZDateTime.now(tz.local).add(const Duration(days:30)),
    NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    ),
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> cancelNotification(int id) async {
  await FlutterLocalNotificationsPlugin().cancel(id);
}

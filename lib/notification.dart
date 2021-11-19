import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _localNotificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    final id = DateTime.now().microsecondsSinceEpoch ~/ 1000;

    final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "notification_channel_id", "notification_channel_id channel",
            importance: Importance.max, priority: Priority.high));
    await _localNotificationsPlugin.show(id, message.notification!.title,
        message.notification!.body, notificationDetails);
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification {
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();


  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _localNotificationsPlugin.initialize(initializationSettings);
  }



  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        "channel name",
        importance: Importance.max,
      ),
      // iOS: IOSNotificationDetails()
    );
  }

  static Future showNotification(RemoteMessage message,int id) async {

    _localNotificationsPlugin.show(id, message.notification!.title,
        message.notification!.body, await _notificationDetails(),
        payload: "test payload");
  }
}

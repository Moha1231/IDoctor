import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hallo_doctor_doctor_app/app/collection/firebase_collection.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings(notificationIconName);

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max, icon: notificationIconName),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future requestPermission() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true);
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('user permission granted');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('user permission provisional');
      } else {
        print('User declie or has not accepted permission');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future removeToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? currentToken = await FirebaseMessaging.instance.getToken();
      if (currentToken != null) {
        await UserService().removeUserToken(currentToken);
      }
      await messaging.deleteToken();
    } catch (e) {
      return Future.error(e);
    }
  }
}

//import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:hallo_doctor_doctor_app/app/routes/app_pages.dart';
import '../styles/styles.dart';
import 'chat_service.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_important_channel", "High Importance Notifications",
    description: 'this channel is used for important notification',
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessaggingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('a big message just show up ' + message.messageId!);
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessaggingBackgroundHandler);
    setupFlutterNotification();
  }
  void setupFlutterNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      "testing",
      "How you doing",
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            color: Styles.primaryBlueColor,
            icon: '@mipmap/ic_launcher'),
      ),
    );
  }

  void listenNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print('Notification type : ' + message.data['type']);
        if (message.data['type'] == 'chat') {
          ///make sure when notification arrive we are not in chat route, because it will be annoying
          ///but we are currently not checking if this notification from this user chat or not
          if (Get.currentRoute == Routes.CHAT) {
            ChatController chatController = Get.find<ChatController>();
            if (chatController.room['id'] == message.data['roomId']) {
              ///notification should not showing if app opening chat with notification from same person arrive
              print(
                  'Notification chat arrive, but app opening chat with the same person');
              return;
            }
          }

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  color: Styles.primaryBlueColor,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ),
          );
        } else {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  color: Styles.primaryBlueColor,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ),
          );
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('a new message opened app are was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      var roomData = await ChatService().getRoomById(message.data['roomId']);
      if (notification != null && android != null) {
        Get.toNamed(Routes.CHAT, arguments: roomData);
      }
    });
  }

  Future<String?> getNotificationToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future notificationStartAppointment(String doctorName, String userId,
      String roomName, String token, String timeSlotId) async {
    try {
      var callable = FirebaseFunctions.instance
          .httpsCallable('notificationStartAppointment');
      await callable({
        'doctorName': doctorName,
        'userId': userId,
        'roomName': roomName,
        'token': token,
        'timeSlotId': timeSlotId
      });
      printInfo(info: 'notification user id : ' + userId);
      print('Notification start appointment send');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

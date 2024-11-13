import 'package:eventown/core/common/logs.dart';
import 'package:eventown/features/notification/local_notification_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHandler {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static String? fcmToken = '';
  static Future init() async {
    //! Request for permission
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    //! Get the token
     fcmToken = await firebaseMessaging.getToken();
    printGreen('FCM Token: $fcmToken');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    //! Handle foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(message);
      printGreen('Notification onMessage: ${message.notification?.title}');
    });
  }

  //! Handle background message
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    LocalNotificationService.showBasicNotification(message);

    printGreen('Notification: ${message.notification?.title}');
  }
}

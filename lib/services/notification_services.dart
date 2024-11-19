import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permissional');
    } else {
      print('User denied or not accepted permission');
    }
  }

  Future<String> getDeviceToken() async {
    String? deviceToken = await messaging.getToken();
    print(deviceToken);
    return deviceToken ?? "";
  }

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'NJMSMaxImportanceNotificationChannel', // id
    'NJMSMaxImportanceNotificationChannel', // title
    importance: Importance.max,
    showBadge: true,
    playSound: true,
    enableVibration: true,
    enableLights: true,
  );

  initLocalNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIos = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIos,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {},
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("payload: ${message.notification?.title}");
      if (Platform.isAndroid) {
        flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification?.title,
          message.notification?.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'NJMSMaxImportanceNotificationChannel',
              'NJMSMaxImportanceNotificationChannel',
              channelDescription: 'Channel Description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
              //icon: 'ic_launcher',

              // other properties...
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
      if (Platform.isIOS) {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  void openFromTerminateState() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {}
  }
}

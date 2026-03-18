/*
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import '../../controllers/home_controllers/notification_controller.dart';
import '../../core/routes/routes_name.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime dateTime;
  final Map<String, dynamic> data;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
    required this.data,
  });
}

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  void initLocalNotifications(BuildContext context) async {
    var androidInitializationSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          if (kDebugMode) {
            print('Notification payload: ${payload.payload}');
          }
          Get.toNamed(RoutesName.notificationView);
        }
    );
  }

  void firebaseInit(BuildContext context) {
    initLocalNotifications(context);
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;

      if (kDebugMode) {
        print("Notification Title: ${notification?.title}");
        print("Notification Body: ${notification?.body}");
        print('Data: ${message.data.toString()}');
      }
      final NotificationController notificationController = Get.put(NotificationController());
      NotificationModel notificationModel = NotificationModel(
        id: message.messageId ?? DateTime.now().toString(),
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
        dateTime: DateTime.now(),
        data: message.data,
      );
      notificationController.addNotification(notificationModel);

      if (Platform.isIOS) {
        foregroundMessage();
      }

      if (Platform.isAndroid) {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Your channel description',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
      icon: '@mipmap/launcher_icon',
      category: AndroidNotificationCategory.message,
      fullScreenIntent: true,
      visibility: NotificationVisibility.public,
    );


    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails
    );

    _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
      payload: message.data.toString(),
    );
  }
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      if (kDebugMode) {
        print('Token Refreshed');
      }
    });
  }
  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (kDebugMode) {
      print('Handling message tap: ${message.data.toString()}');
    }

    final NotificationController notificationController = Get.put(NotificationController());

    NotificationModel notification = NotificationModel(
      id: message.messageId ?? DateTime.now().toString(),
      title: message.notification?.title ?? "No Title",
      body: message.notification?.body ?? "No Body",
      dateTime: DateTime.now(),
      data: message.data,
    );

    notificationController.addNotification(notification);
    notificationController.highlightNotification(notification.id);

    Get.toNamed(RoutesName.notificationView);
  }

  Future foregroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void requestNotificationPermission() async {
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
      if (kDebugMode) print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      if (kDebugMode) print('User granted provisional permission');
    } else {
      if (kDebugMode) print('User denied permission');
    }
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
         await Permission.notification.request();
      }
      if (await Permission.ignoreBatteryOptimizations.isDenied) {
        await Permission.ignoreBatteryOptimizations.request();
      }
    }
  }

}
*/

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  /// Firebase messaging instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Local notification plugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Notification channel
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    playSound: true,
  );

  /// Initialize local notifications
  static Future<void> init() async {

    const AndroidInitializationSettings android =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings settings =
    InitializationSettings(android: android);

    await flutterLocalNotificationsPlugin.initialize(settings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Request permission
  Future<void> requestPermission() async {

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint("Notification Permission: ${settings.authorizationStatus}");
  }

  /// Get FCM device token
  Future<String?> getDeviceToken() async {

    String? token = await _messaging.getToken();

    debugPrint("FCM Token: $token");

    return token;
  }

  /// Foreground message listener
  void firebaseInit(BuildContext context) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      debugPrint("Title: ${message.notification?.title}");
      debugPrint("Body: ${message.notification?.body}");

      showNotification(message);
    });
  }

  /// Notification click handling
  void setupInteractMessage(BuildContext context) {

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

      debugPrint("Notification Clicked");

      /// Example navigation
      /// Get.toNamed(RoutesName.home);
    });
  }

  /// Show notification
  static Future<void> showNotification(RemoteMessage message) async {

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? message.data['title'] ?? "Notification",
      message.notification?.body ?? message.data['body'] ?? "",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/launcher_icon',
        ),
      ),
    );
  }
}
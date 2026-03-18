import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_services.dart';

class FirebaseService {

  static Future<void> init() async {

    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _backgroundHandler(RemoteMessage message) async {

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    await NotificationService.init();
    await NotificationService.showNotification(message);
  }
}
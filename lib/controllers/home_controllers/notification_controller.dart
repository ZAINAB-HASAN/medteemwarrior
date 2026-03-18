import 'package:get/get.dart';
import '../../data/services/notification_services.dart';

class NotificationController extends GetxController {
  var notificationList = <NotificationService>[].obs;
  var unreadCount = 0.obs;
  var highlightedId = ''.obs;

  /*void addNotification(NotificationService notification) {
    if (notificationList.any((n) => n.id == notification.id)) {
      return;
    }
    notificationList.insert(0, notification);
    unreadCount.value++;
  }*/

  void highlightNotification(String id) {
    highlightedId.value = id;
    Future.delayed(const Duration(seconds: 2), () {
      if (highlightedId.value == id) {
        highlightedId.value = '';
      }
    });
  }
  void clearUnreadCount() {
    unreadCount.value = 0;
  }
}

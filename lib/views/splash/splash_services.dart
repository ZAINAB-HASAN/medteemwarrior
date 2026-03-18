import 'dart:async';
import 'package:get/get.dart';
import '../../core/routes/routes_name.dart';
import '../../data/preferences/preference.dart';

class SplashServices {
  final UserPreference userPref = UserPreference();

  void checkLoginStatus() {
    userPref.getUser().then((value) {
      if (value.isLogin == false || value.isLogin == null) {
        Timer(Duration(seconds: 3), () {
          Get.offAllNamed(RoutesName.login);
        });
      } else {
        Timer(Duration(seconds: 3), () {
          Get.offAllNamed(RoutesName.home);
        });
      }
    });
  }
}

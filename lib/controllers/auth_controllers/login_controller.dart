import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/preferences/preference.dart';
import '../../core/utils/custom_snackebar.dart';
import '../../data/services/notification_services.dart';
import '../../models/user_model/user_model.dart';
import '../../repository/auth_repository.dart';
import '../../core/routes/routes_name.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _api = AuthRepository();
  final userPreference = UserPreference();
  String? fcmDeviceToken;
  RxBool loading = false.obs;

  void initNotification(BuildContext context){
    NotificationService notificationServices = NotificationService();

    notificationServices.requestPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);

    notificationServices.getDeviceToken().then((value){
      fcmDeviceToken = value;
      print("FCM Device Token: $value");
    });
  }

  void accountLogin() {
    loading.value = true;
    var data = {
      "userName": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "fcmToken": fcmDeviceToken,
    };
    print('Logged In Data: $data');
    _api.accountLogin(data).then((value) {loading.value = false;
      if (value["action"] == true ){
        UserModel userModel = UserModel.fromJson(value);
        userModel.isLogin = true;
        userPreference.saveUser(userModel).then((_) {
          Utils.showMsg(value);
          Get.offAllNamed(RoutesName.home);
        });
      } else {Utils.showMsg(value);}
    }).catchError((e) {
      loading.value = false;
      Utils.showMsg("No Internet");
    });
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/routes_name.dart';
import '../../core/utils/custom_snackebar.dart';
import '../../repository/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final _api = AuthRepository();
  RxBool loading = false.obs;
  
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();

  void sendOtp() {
    loading.value = true;
    _api.sendOtpApi({"userName": emailController.text.trim()}).then((value) {
      loading.value = false;
      if (value['action'] == true) {
          value['message'] = "${value['message']} OTP: ${value['otp']}";
        Get.toNamed(RoutesName.otpVerification, arguments: emailController.text.trim());
      }
      Utils.showMsg(value);
    }).catchError((e) {
      loading.value = false;
      Utils.showMsg("No Internet");
    });
  }

  void verifyOtp(String email) {
    loading.value = true;
    _api.verifyOtpApi({"userName": email, "otp": otpController.text.trim()}).then((value) {
      loading.value = false;
      if (value['action'] == true) {
        Get.toNamed(RoutesName.resetPassword, arguments: email);
      }
      Utils.showMsg(value);
    }).catchError((e) {
      loading.value = false;
      Utils.showMsg("No Internet");
    });
  }

  void resetPassword(String email) {
    loading.value = true;
    _api.resetPasswordApi({
      "userName": email,
      "newPassword": newPasswordController.text.trim(),
    }).then((value) {
      loading.value = false;
      if (value['action'] == true) Get.offAllNamed(RoutesName.login);
      Utils.showMsg(value);
    }).catchError((e) {
      loading.value = false;
      Utils.showMsg("No Internet");
    });
  }
}

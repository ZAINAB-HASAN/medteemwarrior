import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';

class Utils {
  static void showMsg(dynamic value) {
    Get.closeAllSnackbars();
    
    String message = "Something went wrong";
    bool isSuccess = false;

    if (value is Map) {
      message = value['message'].toString();
      isSuccess = value['action'] == true;
    } else if (value is String) {
      message = value;
    }

    Get.rawSnackbar(
      message: message,
      backgroundColor: AppColors.appColor,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(5),
      borderRadius: 5,
      icon: Icon(
        isSuccess ? Icons.check_circle : Icons.error,
        color: AppColors.appWhite,
      ),
      duration: Duration(seconds: 3),
    );
  }

  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

}

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:med_teem_app/core/theme/app_text_style.dart';
import '../../core/assets/assets_images.dart';
import '../../core/routes/routes_name.dart';
import '../../core/theme/app_colors.dart';

import 'splash_services.dart';
import '../../data/services/notification_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    /*NotificationService notificationServices = NotificationService();
    notificationServices.requestPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value){
      print("Device Token: $value");
    });*/
    splashServices.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).colorScheme;
    final isDark = appTheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: appTheme.shadow,
      body: Stack(
        children: [
          Positioned(
            top: -30,
            left: -30,
            child: _buildBlurCircle(100, AppColors.appColor),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _buildBlurCircle(200, AppColors.appColor.withOpacity(0.7)),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.appColor.withOpacity(0.05),
                  AppColors.appColor.withOpacity(0.05),
                ],
              ),
            ),
          ),

          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SpinKitSpinningLines(
                  color: appTheme.scrim,
                  lineWidth: 5,
                  size: 170,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: appTheme.shadow,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.appColor.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: ClipOval(
                      child: Image.asset(
                        AssetsImages.appLogo2,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                        color: isDark ? AppColors.appWhite : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  AssetsImages.appLogo1,
                  height: 50,
                  fit: BoxFit.contain,
                  color: isDark ? AppColors.appWhite : null,
                ),
                SizedBox(height: 10),
                Text(
                  "Version 1.0.0",
                  style: mTextStyle12(textColor: appTheme.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_teem_app/core/assets/assets_fonts.dart';
import 'package:med_teem_app/core/assets/assets_images.dart';
import 'package:med_teem_app/core/custom_widgets/custom_input/custom_text_field.dart';
import 'package:med_teem_app/core/custom_widgets/app_button/round_button.dart';
import 'package:med_teem_app/core/theme/app_colors.dart';
import 'package:med_teem_app/core/theme/app_text_style.dart';
import '../../controllers/auth_controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ForgotPasswordController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: appTheme.shadow,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.appColor.withOpacity(0.05),
                  AppColors.appColor.withOpacity(0.1),
                ],
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.appColor),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.appColor.withOpacity(0.7)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.appColor.withOpacity(0.3),
                              blurRadius: 50,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            AssetsImages.appLogo2,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            color: isDark ? AppColors.appWhite : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 230,
                        child: Image.asset(
                          AssetsImages.appLogo3,
                          height: 80,
                          color: isDark ? AppColors.appWhite : null,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              appTheme.surface,
                              AppColors.appColor,
                              appTheme.surface,
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 30),
                        decoration: BoxDecoration(
                          color: appTheme.shadow.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.appColor, width: 0.5),
                          boxShadow: [
                            BoxShadow(color: AppColors.appColor.withOpacity(0.1), blurRadius: 10),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Forgot Password',
                              style: mTextStyle20(
                                fontWeight: FontWeight.bold,
                                textColor: appTheme.primary,
                              ).copyWith(
                                fontFamily: AssetsFonts.typoGraphica,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Enter your Username or Email to receive a verification code',
                              textAlign: TextAlign.center,
                              style: mTextStyle13(textColor:appTheme.onSurface,),
                            ),
                            SizedBox(height: 30),
                            CustomTextField(
                              controller: controller.emailController,
                              hintText: 'Username / Email',
                              prefixIcon: Icons.person_outline_rounded,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter username or email';
                                }
                                if (value.contains('@')) {
                                  if (!GetUtils.isEmail(value)) {
                                    return 'Enter a valid email address';
                                  }
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),
                            Obx(() => RoundButton(
                                  title: 'Send OTP',
                                  loading: controller.loading.value,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.sendOtp();
                                    }
                                  },
                                )),
                            SizedBox(height: 15),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Back to Login',
                                style: mTextStyle13(
                                  textColor: appTheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

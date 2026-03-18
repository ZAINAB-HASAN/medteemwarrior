import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_teem_app/core/assets/assets_fonts.dart';
import 'package:med_teem_app/core/assets/assets_images.dart';
import 'package:med_teem_app/core/custom_widgets/custom_input/custom_text_field.dart';
import 'package:med_teem_app/core/custom_widgets/app_button/round_button.dart';
import 'package:med_teem_app/core/theme/app_colors.dart';
import 'package:med_teem_app/core/theme/app_text_style.dart';
import '../../core/routes/routes_name.dart';
import '../../controllers/auth_controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());
  bool _obscurePassword = true;

  void submit() {
    if (_formKey.currentState!.validate()) {
      controller.accountLogin();
    }
    //Get.toNamed(RoutesName.dashboard);
  }

  @override
  void initState() {
    super.initState();
    controller.initNotification(context);
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.appColor,
              ),
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.appColor.withOpacity(0.7),
              ),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 10),
                      Container(
                        height: 2,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              appTheme.shadow,
                              AppColors.appColor,
                              appTheme.shadow,
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: appTheme.shadow.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppColors.appColor,
                            width: 0.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.appColor.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Login',
                              style:
                                  mTextStyle20(
                                    fontWeight: FontWeight.bold,
                                    textColor: appTheme.primary,
                                  ).copyWith(
                                    fontFamily: AssetsFonts.typoGraphica,
                                    letterSpacing: 3,
                                  ),
                            ),
                            SizedBox(height: 30),
                            CustomTextField(
                              controller: controller.emailController,
                              hintText: 'Username/Email',
                              prefixIcon: Icons.alternate_email_rounded,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter username or email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 18),
                            CustomTextField(
                              controller: controller.passwordController,
                              hintText: 'Password',
                              prefixIcon: Icons.lock_outline_rounded,
                              isPassword: _obscurePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter password';
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: AppColors.appGray,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(RoutesName.forgotPassword);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: mTextStyle12(
                                    textColor: appTheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Obx(
                              () => RoundButton(
                                title: 'Login',
                                loading: controller.loading.value,
                                onTap: submit,
                              ),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RoutesName.termsAndConditions);
                              },
                              child: Text(
                                'Terms and Conditions',
                                style: mTextStyle12(
                                  textColor: AppColors.appColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.verified_user_outlined,
                                  size: 14,
                                  color: appTheme.onSurface,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Authorized Med Teem Staff Access Only',
                                  style: mTextStyle10(
                                    textColor: appTheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
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

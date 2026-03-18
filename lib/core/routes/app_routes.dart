import 'package:get/get.dart';
import 'package:med_teem_app/core/bottom_navigation/custom_bottom_navbar.dart';
import 'package:med_teem_app/core/routes/routes_name.dart';
import 'package:med_teem_app/views/auth/login_view.dart';
import 'package:med_teem_app/views/auth/otp_verification_view.dart';
import 'package:med_teem_app/views/auth/forgot_password_view.dart';
import 'package:med_teem_app/views/auth/reset_password_view.dart';
import 'package:med_teem_app/views/auth/terms_conditions_view.dart';
import 'package:med_teem_app/views/splash/splash_view.dart';
import 'package:med_teem_app/views/notification/notification_view.dart';

import '../../views/bottom_tab_view/calls_tab/call/calls_details_screen.dart';


class AppRoutes {
  static appRoutes() => [
    GetPage(name: RoutesName.splash, page: () => SplashView()),
    GetPage(name: RoutesName.login, page: () => LoginView()),
    GetPage(name: RoutesName.forgotPassword, page: () => ForgotPasswordView()),
    GetPage(
      name: RoutesName.otpVerification,
      page: () => OtpVerificationView(),
    ),
    GetPage(name: RoutesName.resetPassword, page: () => ResetPasswordView()),
    GetPage(
      name: RoutesName.termsAndConditions,
      page: () => TermsConditionsView(),
    ),
    GetPage(name: RoutesName.home, page: () => CustomBottomNavbar()),
    GetPage(name: RoutesName.notificationView, page: () => NotificationView()),
    GetPage(
      name: RoutesName.callsDetailsView,
      page: () => CallsDetailsScreen(),
    ),
  ];
}

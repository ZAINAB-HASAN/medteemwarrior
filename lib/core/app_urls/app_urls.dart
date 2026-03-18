class AppUrl {
  ///=======================================///
  static const String baseUrl = "https://testingapi.veggift.com/api";
  static const String baseImageUrl = "https://testingapi.veggift.com";

  ///=======================================///

  ///---------------------------///
  static const String login = "$baseUrl/employee/login";

  ///---------------------------///
  static const String sendOtp = "$baseUrl/employee/sendOtp";

  ///--------------------------///
  static const String verifyOtp = "$baseUrl/employee/verifyOtp";

  ///---------------------------///
  static const String resetPassword = "$baseUrl/employee/resetPassword";

  ///--------------------------///
  static const String changePassword = "$baseUrl/employee/changePassword";

  ///--------------------------///
  static const String supportCall = "$baseUrl/employee/supportcall";

  ///--------------------------///
  static const String searchPart = "$supportCall/searchParts";

  ///--------------------------///
  static const String partsRequest = "$supportCall/partsRequest";

  ///--------------------------///
  static const String updateStatus = "$supportCall/updateStatus";

  ///--------------------------///
  static const String dashboard = "$baseUrl/employee/dashboard";

  ///--------------------------///
  static const String profileUpdate = "$baseUrl/employee/profileUpdate";
}

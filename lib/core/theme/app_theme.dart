import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      shadow: AppColors.appWhite,
      scrim: AppColors.appColor,
      primary: AppColors.appBlack,
      onSurface: AppColors.appBlack,
      surface: AppColors.appWhite,
      surfaceDim: AppColors.appGray,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      shadow: AppColors.appNavi,
      scrim: AppColors.appColor2,
      primary: AppColors.appWhite,
      onSurface: AppColors.appWhite,
      surface: AppColors.appGray,
        surfaceDim: AppColors.appBlack
    ),
  );
}

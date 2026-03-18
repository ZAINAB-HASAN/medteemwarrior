import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hintColor = isDark ? AppColors.appLightGray : AppColors.appGray;

    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      keyboardType: keyboardType,
      style: mTextStyle14(
        textColor: appTheme.primary,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: mTextStyle14(textColor: hintColor),
        prefixIcon: Icon(prefixIcon, color: hintColor),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: appTheme.shadow,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.appGray.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.appGray.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.appColor, width: 1.5),
        ),
      ),
    );
  }
}

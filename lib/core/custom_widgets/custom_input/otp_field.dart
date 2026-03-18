import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';

class OtpField extends StatelessWidget {
  final int length;
  final TextEditingController? controller;
  final ValueChanged<String>? onCompleted;

  const OtpField({super.key, this.length = 6, this.onCompleted, this.controller});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).colorScheme;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 55,
      textStyle: mTextStyle18(
        textColor: appTheme.primary,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: appTheme.shadow,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.appGray.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );

    return Pinput(
      length: length,
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: AppColors.appColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.appColor.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: AppColors.appColor.withOpacity(0.05),
          border: Border.all(color: AppColors.appColor, width: 1),
        ),
      ),
      onCompleted: onCompleted,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: AppColors.appColor,
          ),
        ],
      ),
    );
  }
}

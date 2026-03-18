import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:med_teem_app/core/theme/app_colors.dart';
import '../../theme/app_text_style.dart';

class ExceptionWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final String actionButtonTitle;
  final VoidCallback onActionPressed;
  final String cancelButtonTitle;
  final VoidCallback? onCancelPressed;

  const ExceptionWidget({
    super.key,
    required this.icon,
    this.iconColor,
    required this.title,
    required this.subtitle,
    required this.actionButtonTitle,
    required this.onActionPressed,
    this.cancelButtonTitle = 'Cancel',
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E).withOpacity(0.85),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.appWhite.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.appBlack.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.help_outline_rounded,
                        color: AppColors.appWhite.withOpacity(0.5),
                        size: 20,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (iconColor ?? AppColors.appWhite).withOpacity(
                          0.1,
                        ),
                      ),
                      child: Icon(
                        icon,
                        size: 50,
                        color: iconColor ?? AppColors.appColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: mTextStyle16(
                        textColor: AppColors.appWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: mTextStyle14(
                        textColor: AppColors.appWhite.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap:
                                onCancelPressed ?? () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.appWhite.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                cancelButtonTitle,
                                style: mTextStyle14(
                                  textColor: AppColors.appWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: onActionPressed,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.appWhite.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.appWhite.withOpacity(0.05),
                                ),
                              ),
                              child: Text(
                                actionButtonTitle,
                                style: mTextStyle14(
                                  textColor: AppColors.appWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

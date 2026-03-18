import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme =Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: appTheme.surface,
      appBar: AppBar(
        title: Text(
          "Notifications",
            style: mTextStyle15(
                fontWeight: FontWeight.bold,
                textColor: appTheme.primary
            )
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.appColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_rounded,
                size: 80,
                color: AppColors.appColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Notifications",
              style: mTextStyle22(
                fontWeight: FontWeight.bold,
                textColor: appTheme.primary
              )
            ),
            const SizedBox(height: 12),
            Text(
              "You have no new notifications",
                style: mTextStyle16(
                    textColor: appTheme.surface
                )
            ),
          ],
        ),
      ),
    );
  }
}

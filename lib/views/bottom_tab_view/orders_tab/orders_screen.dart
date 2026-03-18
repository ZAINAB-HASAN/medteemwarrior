import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: appTheme.surface,
      appBar: AppBar(
        title: Text(
          "My Orders",
            style: mTextStyle16(
            fontWeight: FontWeight.bold,
            textColor: appTheme.primary
        )
        ),
        backgroundColor: appTheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.appColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_rounded,
                size: 80,
                color: AppColors.appColor,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "My Orders",
                style: mTextStyle22(
                fontWeight: FontWeight.bold,
                textColor: appTheme.primary
            )
            ),
            SizedBox(height: 12),
            Text(
              "Your order history will appear here",
                style: mTextStyle16(
                    fontWeight: FontWeight.bold,
                    textColor: appTheme.primary
                )
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AppBarLoadingWidget extends StatelessWidget {
  final bool isLoading;

  const AppBarLoadingWidget({super.key, required this.isLoading});
  @override
  Widget build(BuildContext context) {
    return isLoading ? SizedBox(
      height: 1,
      child: LinearProgressIndicator(
        trackGap: 1,
        backgroundColor: AppColors.appWhite,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor),
      ),
    )
        : SizedBox(height: 3);
  }
}
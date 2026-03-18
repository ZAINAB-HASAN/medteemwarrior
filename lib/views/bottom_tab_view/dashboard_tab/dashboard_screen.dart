/*
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controllers/dashboard/dashboard_controller.dart';
import '../../../core/routes/routes_name.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../controllers/home_controllers/notification_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    controller.getDashboardData(); //

    final appTheme = Theme.of(context).colorScheme;
    final NotificationController notificationController = Get.put(
      NotificationController(),
    );

    return Scaffold(
      backgroundColor: appTheme.shadow,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dashboard',
                    style: mTextStyle20(
                      textColor: appTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(RoutesName.notificationView);
                          },
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: appTheme.primary,
                            size: 28,
                          ),
                        ),
                        if (notificationController.unreadCount.value > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.appWhite,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.3),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                notificationController.unreadCount.value > 9
                                    ? '9+'
                                    : notificationController.unreadCount.value
                                          .toString(),
                                style: mTextStyle10(
                                  textColor: AppColors.appWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.appColor.withOpacity(0.1),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.appColor.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.dashboard_rounded,
                          size: 80,
                          color: AppColors.appColor,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Welcome to Dashboard',
                        style: mTextStyle20(
                          textColor: appTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Your overview and analytics',
                        style: mTextStyle14(
                          textColor: appTheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controllers/dashboard/dashboard_controller.dart';
import '../../../core/routes/routes_name.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../controllers/home_controllers/notification_controller.dart';
import '../../../data/response/status.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    controller.getDashboardData(); // API call

    final appTheme = Theme.of(context).colorScheme;

    final NotificationController notificationController = Get.put(
      NotificationController(),
    );

    return Scaffold(
      backgroundColor: appTheme.shadow,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dashboard',
                    style: mTextStyle20(
                      textColor: appTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(RoutesName.notificationView);
                          },
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: appTheme.primary,
                            size: 28,
                          ),
                        ),
                        if (notificationController.unreadCount.value > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                notificationController.unreadCount.value > 9
                                    ? '9+'
                                    : notificationController.unreadCount.value
                                          .toString(),
                                style: mTextStyle10(
                                  textColor: AppColors.appWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Dashboard Data
            Expanded(
              child: Obx(() {
                if (controller.rxRequestStatus.value == Status.LOADING) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.rxRequestStatus.value == Status.ERROR) {
                  return Center(child: Text(controller.error.value));
                }

                final data = controller.dashboardData;

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                    children: [
                      _dashboardCard(
                        "Assigned Calls",
                        data['assignedCallCount'] ?? 0,
                        Icons.assignment,
                      ),

                      _dashboardCard(
                        "Completed Calls",
                        data['completedCallCount'] ?? 0,
                        Icons.check_circle,
                      ),

                      _dashboardCard(
                        "Unresolved Calls",
                        data['unresolvedCallCount'] ?? 0,
                        Icons.error_outline,
                      ),

                      _dashboardCard(
                        "Parts Request",
                        data['partsRequestCount'] ?? 0,
                        Icons.build,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(String title, int count, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: AppColors.appColor),
          const SizedBox(height: 6),

          Text(
            count.toString(),
            style: mTextStyle20(
              textColor: AppColors.appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),

          Text(
            title,
            textAlign: TextAlign.center,
            style: mTextStyle12(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

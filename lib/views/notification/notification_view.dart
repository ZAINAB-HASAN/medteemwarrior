import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../controllers/home_controllers/notification_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';


class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.clearUnreadCount();
    });

    return Scaffold(
      backgroundColor: isDark ? AppColors.appBlack : AppColors.appWhite,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: mTextStyle18(
            textColor: isDark ? AppColors.appWhite : AppColors.appBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? AppColors.appWhite : AppColors.appBlack,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() => controller.notificationList.isNotEmpty
              ? TextButton(
                  onPressed: () {
                    controller.notificationList.clear();
                  },
                  child: Text(
                    'Clear All',
                    style: mTextStyle14(textColor: AppColors.appColor),
                  ),
                )
              : SizedBox()),
        ],
      ),
      body: Obx(() {
        if (controller.notificationList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.appColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_off_outlined,
                    size: 80,
                    color: AppColors.appColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'No notifications yet',
                  style: mTextStyle16(
                    textColor: isDark ? AppColors.appWhite : AppColors.appBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'We\'ll notify you when something\nimportant happens.',
                  textAlign: TextAlign.center,
                  style: mTextStyle14(
                    textColor: AppColors.appGray,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16),
          itemCount: controller.notificationList.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final notification = controller.notificationList[index];
            return Obx(() {
              //final isHighlighted = controller.highlightedId.value == notification.id;
              final isHighlighted = controller.highlightedId.value == 7;

              return Container(
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? AppColors.appColor.withOpacity(0.15)
                      : (isDark ?AppColors.appBlack : AppColors.appWhite),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.appBlack.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: isHighlighted
                      ? Border.all(color: AppColors.appColor.withOpacity(0.5), width: 1.5)
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.appColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _getIcon('notification.title'),
                                color: AppColors.appColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'notification.title',
                                          style: mTextStyle14(
                                            textColor: isDark ? AppColors.appWhite : AppColors.appBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      /*LiveTimeText(
                                        dateTime: notification.dateTime,
                                        style: mTextStyle11(
                                          textColor: AppColors.appLightGray,
                                        ),
                                      ),*/
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  ReadMoreText(
                               ' notification.body',
                                trimLines: 2,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' Show more',
                                trimExpandedText: ' Show less',
                                style: mTextStyle13(
                                  textColor: isDark
                                      ? AppColors.appLightGray
                                      : AppColors.appGray,
                                  height: 1.4,
                                ),
                                moreStyle: TextStyle(
                                  color: AppColors.appColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                lessStyle: TextStyle(
                                  color: AppColors.appColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        );
      }),
    );
  }

  IconData _getIcon(String title) {
    String t = title.toLowerCase();
    if (t.contains('offer') || t.contains('discount')) return Icons.local_offer_rounded;
    if (t.contains('update')) return Icons.update_rounded;
    if (t.contains('urgent') || t.contains('alert')) return Icons.warning_amber_rounded;
    if (t.contains('success')) return Icons.check_circle_rounded;
    return Icons.notifications_active_rounded;
  }
}

class LiveTimeText extends StatefulWidget {
  final DateTime dateTime;
  final TextStyle style;

  const LiveTimeText({
    super.key,
    required this.dateTime,
    required this.style,
  });

  @override
  State<LiveTimeText> createState() => _LiveTimeTextState();
}

class _LiveTimeTextState extends State<LiveTimeText> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getTimeAgo(widget.dateTime),
      style: widget.style,
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
    if (difference.inSeconds > 10) return '${difference.inSeconds}s ago';
    return 'Just now';
  }
}

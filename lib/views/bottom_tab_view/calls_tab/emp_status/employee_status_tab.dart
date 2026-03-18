import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:med_teem_app/core/routes/routes_name.dart';

import '../../../../../controllers/home_controllers/call/call_controller.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../data/response/status.dart';
import '../../../../../models/call_screen_models/call_model.dart';
import '../../../../core/theme/app_colors.dart';

class EmployeeStatusTab extends StatelessWidget {
  const EmployeeStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CallController>();
    final theme = Theme.of(context).colorScheme;

    return Obx(() {
      if (controller.rxRequestStatus.value == Status.LOADING) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.rxRequestStatus.value == Status.ERROR) {
        return Center(child: Text(controller.error.value));
      }

      final calls = controller.callList.value.data?.calls ?? [];

      if (calls.isEmpty) {
        return const Center(child: Text("No Status Found"));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: calls.length,
        itemBuilder: (_, index) {
          return _buildStatusCard(calls[index], theme);
        },
      );
    });
  }

  Widget _buildStatusCard(CallItem call, ColorScheme theme) {
    DateTime dateTime = DateTime.parse(call.scheduleAt!);
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);

    print(formattedDate);
    final employeeStatus = call.employeeStatus;
    /*final emp = call.supportCallAssignment?.isNotEmpty == true
        ? call.supportCallAssignment!.first.employee
        : null;*/
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.onSurface.withValues(alpha: .08)),
      ),
      child: InkWell(
        onTap: () => Get.toNamed(
          RoutesName.callsDetailsView,
          arguments: {'call': call, "fromHistory": true},
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.appColor.withValues(alpha: .1),
              child: const Icon(Icons.person_outline),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.customer!.name ?? "No Customer",
                    style: mTextStyle16(
                      fontWeight: FontWeight.w600,
                      textColor: theme.primary,
                    ),
                  ),
                  Text(
                    call.title ?? "No Title",
                    style: mTextStyle14(
                      fontWeight: FontWeight.w500,
                      textColor: theme.primary,
                    ),
                  ),
                  Text(
                    call.status ?? "No status",
                    style: mTextStyle14(
                      textColor: theme.onSurface.withValues(alpha: .6),
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: mTextStyle12(
                      textColor: theme.onSurface.withValues(alpha: .6),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getStatusColor(call.employeeStatus ?? ""),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                (call.employeeStatus ?? "No Status").capitalizeFirst!,
                style: mTextStyle12(textColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "open":
        return Colors.yellow;
      case "closed":
        return Colors.red;
      case "inprogress":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  /*Widget _buildCallCard(
      BuildContext context,
      CallItem call,
      ColorScheme theme,
      ) {
    DateTime dateTime = DateTime.parse(call.scheduleAt!);
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);

    print(formattedDate);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.onSurface.withValues(alpha: .08)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Get.toNamed(
            RoutesName.callsDetailsView,
            arguments: {'call': call, "fromHistory": true},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.appColor.withValues(alpha: .1),
                child: const Icon(Icons.person_outline),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      call.customer!.name ?? "No Customer",
                      style: mTextStyle16(
                        fontWeight: FontWeight.w600,
                        textColor: theme.primary,
                      ),
                    ),
                    Text(
                      call.title ?? "No Title",
                      style: mTextStyle14(
                        fontWeight: FontWeight.w500,
                        textColor: theme.primary,
                      ),
                    ),
                    Text(
                      call.status ?? "No status",
                      style: mTextStyle14(
                        textColor: theme.onSurface.withValues(alpha: .6),
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: mTextStyle12(
                        textColor: theme.onSurface.withValues(alpha: .6),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  call.priority ?? "Normal",
                  style: mTextStyle12(
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}

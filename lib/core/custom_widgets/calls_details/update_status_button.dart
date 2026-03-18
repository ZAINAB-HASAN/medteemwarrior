import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controllers/call/call_controller.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../core/theme/app_colors.dart';
import '../app_button/round_button.dart';

class UpdateStatusSection extends StatelessWidget {
  final ColorScheme theme;
  final int supportCallId;

  const UpdateStatusSection({
    super.key,
    required this.theme,
    required this.supportCallId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CallController>();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.onSurface.withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _openStatusBottomSheet(context, theme, controller),
        child: Center(
          child: Text(
            "Update Status",
            style: mTextStyle16(
              textColor: theme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  /// BottomSheet
  void _openStatusBottomSheet(
      BuildContext context,
      ColorScheme theme,
      CallController controller,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 5,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.appGray.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 14),

              /// Title
              Text(
                "Update Status",
                style: mTextStyle20(
                  textColor: theme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              /// STATUS DROPDOWN
              Obx(
                    () => DropdownButtonFormField<String>(
                  value: controller.selectedStatus.value.isEmpty
                      ? null
                      : controller.selectedStatus.value,
                  decoration: InputDecoration(
                    labelText: "Select Status",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: controller.statusList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedStatus.value = value ?? '';
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// Remark
              TextFormField(
                controller: controller.remarkStatusController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Remark",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Submit
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Obx(
                      () => RoundButton(
                    title: controller.updateStatusLoading.value
                        ? "Please wait..."
                        : "Submit Request",
                    onTap: () async {
                      bool success = await controller.updateSupportStatus(
                        supportCallId: supportCallId,
                      );

                      if (success) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
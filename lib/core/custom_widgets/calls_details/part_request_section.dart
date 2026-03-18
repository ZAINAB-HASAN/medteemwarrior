import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controllers/call/call_controller.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../data/response/status.dart';
import '../../../core/custom_widgets/bottom_sheet/search_part_bottom_sheet.dart';

class PartRequestSection extends StatelessWidget {
  final ColorScheme theme;
  final int supportCallId;

  const PartRequestSection({
    super.key,
    required this.theme,
    required this.supportCallId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CallController>();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Part Request Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: theme.onSurface.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => _openPartSearchSheet(context),
              child: Center(
                child: Text(
                  "Part Request",
                  style: mTextStyle14(
                    fontWeight: FontWeight.bold,
                    textColor: theme.onSurface,
                  ),
                ),
              ),
            ),
          ),

          /// Loading
          if (controller.rxRequestStatus.value == Status.LOADING)
            const Center(child: CircularProgressIndicator()),

          /// Error
          if (controller.rxRequestStatus.value == Status.ERROR)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(controller.error.value),
            ),

          /// Data
          if (controller.rxRequestStatus.value == Status.COMPLETED) ...[
            if (controller.partRequestDetailsList.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8),
                child: Center(child: Text("No Part Requests Found")),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.partRequestDetailsList.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final request = controller.partRequestDetailsList[index];
                  final items = request.partsRequestItems ?? [];

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.surfaceContainerHighest,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Requested By: ${request.employee?.name ?? "Unknown"}",
                          style: mTextStyle14(
                            fontWeight: FontWeight.bold,
                            textColor: theme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),

                        ...items.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${index + 1}. ${item.product?.title ?? "Unknown Product"}',
                                    style: mTextStyle14(
                                      fontWeight: FontWeight.w500,
                                      textColor: theme.onSurface,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Qty: ${item.requestedQty ?? 0}",
                                  style: mTextStyle14(
                                    textColor: theme.onSurface.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
          ],
        ],
      );
    });
  }

  Future<void> _openPartSearchSheet(BuildContext context) async {
    final controller = Get.find<CallController>();

    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SearchPartBottomSheet(supportCallId: supportCallId),
    );

    /// Refresh after bottom sheet close
    if (result == true) {
      await controller.getPartRequestDetails(supportCallId);
    }
  }
}

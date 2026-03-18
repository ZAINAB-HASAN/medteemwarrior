import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/home_controllers/call/call_controller.dart';
import '../../../../core/custom_widgets/calls_details/assigned_employee_section.dart';
import '../../../../core/custom_widgets/calls_details/call_header_section.dart';
import '../../../../core/custom_widgets/calls_details/call_info_section.dart';
import '../../../../core/custom_widgets/calls_details/customer_info_section.dart';
import '../../../../core/custom_widgets/calls_details/part_request_section.dart';
import '../../../../core/custom_widgets/calls_details/update_status_button.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../models/call_screen_models/call_model.dart';

class CallsDetailsScreen extends StatefulWidget {
  const CallsDetailsScreen({super.key});

  @override
  State<CallsDetailsScreen> createState() => _CallsDetailsScreenState();
}

class _CallsDetailsScreenState extends State<CallsDetailsScreen> {
  final CallItem call = Get.arguments['call'];
  final ColorScheme theme = Get.theme.colorScheme;
  final bool fromHistory = Get.arguments['fromHistory'];

  final controller = Get.find<CallController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPartRequestDetails(call.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(call.title ?? 'Call Details')),
      body: Container(
        color: theme.surface,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CallHeaderSection(call: call, theme: theme),
                    SizedBox(height: 8),
                    CallInfoSection(call: call, theme: theme),

                    if (call.product != null) ...[
                      const SizedBox(height: 16),
                      _sectionHeader("Product Details", theme),
                      _detailRow(
                        "Product",
                        call.product?.title ?? "N/A",
                        theme,
                      ),
                    ],

                    const SizedBox(height: 16),
                    _sectionHeader("Customer Information", theme),
                    CustomerInfoSection(call: call,theme: theme,),

                    const SizedBox(height: 16),
                    _sectionHeader("Description", theme),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.onSurface.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        call.description ?? "No description provided.",
                        style: mTextStyle14(
                          textColor: theme.onSurface.withValues(alpha: 0.8),
                        ).copyWith(height: 1.5),
                      ),
                    ),

                    const SizedBox(height: 16),
                    AssignedEmployeeSection(call: call, theme: theme),

                    if (!fromHistory) ...[
                      /// Part Request
                      PartRequestSection(theme: theme, supportCallId: call.id!),

                      /// Update Status
                      UpdateStatusSection(
                        theme: Theme.of(context).colorScheme,
                        supportCallId: call.id!,
                      ),
                    ],

                    if (call.resolutionNote != null) ...[
                      const SizedBox(height: 24),
                      _sectionHeader("Resolution", theme),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          //color: Colors.green.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          call.resolutionNote ?? "",
                          style: mTextStyle14(
                            textColor: theme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, ColorScheme theme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: mTextStyle16(
          fontWeight: FontWeight.bold,
          textColor: theme.onSurface.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, ColorScheme theme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: mTextStyle14(
                textColor: theme.onSurface.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: mTextStyle16(
                textColor: theme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

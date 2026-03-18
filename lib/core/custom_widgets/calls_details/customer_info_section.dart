import 'package:flutter/material.dart';

import '../../../models/call_screen_models/call_model.dart';

class CustomerInfoSection extends StatelessWidget {
  final CallItem call;
  final ColorScheme theme;

  const CustomerInfoSection({
    super.key,
    required this.call,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row('Id', call.customer!.id.toString() ?? "No Name"),
        _row('Name', call.customer!.name ?? "No Name"),
        _row('Company Name', call.customer!.companyName ?? "-"),
        _row('Email', safeValue(call.customer?.email)),
        _row('Mobile Number', call.customer!.mobileNo ?? "No Company Name "),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  String safeValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "-";
    }
    return value;
  }
}

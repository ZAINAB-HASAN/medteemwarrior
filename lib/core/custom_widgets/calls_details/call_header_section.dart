import 'package:flutter/material.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../models/call_screen_models/call_model.dart';

class CallHeaderSection extends StatelessWidget {
  final CallItem call;
  final ColorScheme theme;

  const CallHeaderSection({
    super.key,
    required this.call,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statusBadge(call.status ?? "Unknown"),
        Text(
          call.createdAt?.split('T')[0] ?? '',
          style: mTextStyle14(
            textColor: theme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String status) {
    Color color = Colors.grey;

    if (status.toLowerCase() == 'open') color = Colors.green;
    if (status.toLowerCase() == 'closed') color = Colors.red;
    if (status.toLowerCase() == 'pending') color = Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../models/call_screen_models/call_model.dart';

class CallInfoSection extends StatelessWidget {
  final CallItem call;
  final ColorScheme theme;

  const CallInfoSection({
    super.key,
    required this.call,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          call.title ?? "Details",
          style: mTextStyle22(
            fontWeight: FontWeight.bold,
            textColor: theme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Call Information".toUpperCase(),
          style: mTextStyle16(
            fontWeight: FontWeight.bold,
            textColor: theme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 12),

        _row("Ticket No", call.ticketNo ?? "N/A"),
        _row("Priority", call.priority ?? "Normal"),
        _row(
          "Scheduled",
          call.scheduleAt?.replaceAll('T', ' ').split('.')[0] ?? "N/A",
        ),
        _row("Location", call.location ?? "N/A"),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label),
          ),
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
}
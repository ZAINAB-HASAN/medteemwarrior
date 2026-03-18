import 'package:flutter/material.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../models/call_screen_models/call_model.dart';

class AssignedEmployeeSection extends StatelessWidget {
  final CallItem call;
  final ColorScheme theme;

  const AssignedEmployeeSection({
    super.key,
    required this.call,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (call.supportCallAssignment == null ||
        call.supportCallAssignment!.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ASSIGNED EMPLOYEE",
          style: mTextStyle16(
            fontWeight: FontWeight.bold,
            textColor: theme.onSurface,
          ),
        ),
        const SizedBox(height: 12),

        ...call.supportCallAssignment!.map((assignment) {
          final emp = assignment.employee;
          if (emp == null) return const SizedBox();

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.onSurface.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  /*backgroundImage:
            (emp.image != null && emp.image!.isNotEmpty)
                ? NetworkImage(emp.image!)
                : null,
              child: (emp.image == null || emp.image!.isEmpty)
                  ? Icon(Icons.person)
                  : null,*/
                  child: Icon(Icons.person_outline),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        emp.name ?? "",
                        style: mTextStyle16(
                          fontWeight: FontWeight.bold,
                          textColor: theme.primary,
                        ),
                      ),
                      Text(emp.email ?? ""),
                      Text(emp.mobileNo ?? ""),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

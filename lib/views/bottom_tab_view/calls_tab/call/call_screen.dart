import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/home_controllers/call/call_controller.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../data/response/status.dart';
import '../../../../core/custom_widgets/loading/app_bar_loading_widget.dart';
import '../emp_status/employee_status_tab.dart';
import 'calls_tab.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CallController());
    final theme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.surface,
        appBar: AppBar(
          title: Text(
            "Support Calls",
            style: mTextStyle20(
              fontWeight: FontWeight.bold,
              textColor: theme.primary,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: "Calls"),
                    Tab(text: "History"),
                  ],
                ),

                /// Loading line
                Obx(
                  () => AppBarLoadingWidget(
                    isLoading:
                        controller.rxRequestStatus.value == Status.LOADING,
                  ),
                ),
              ],
            ),
          ),
        ),

        body: const TabBarView(children: [CallsTab(), EmployeeStatusTab()]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controllers/call/call_controller.dart';
import '../../../data/preferences/preference.dart';
import '../../../data/response/status.dart';
import '../../../models/call_screen_models/searched_part_items.dart';
import '../../theme/app_text_style.dart';
import '../app_button/round_button.dart';

class SearchPartBottomSheet extends StatefulWidget {
  final int supportCallId;

  const SearchPartBottomSheet({super.key, required this.supportCallId});

  @override
  State<SearchPartBottomSheet> createState() => _SearchPartBottomSheetState();
}

class _SearchPartBottomSheetState extends State<SearchPartBottomSheet> {
  final CallController controller = Get.find<CallController>();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController remarkCtrl = TextEditingController();

  /// Selected searched parts
  final List<Data> selectedParts = [];
  final Map<int, int> partQty = {}; // key = part.id , value = quantity
  final userPreference = UserPreference();

  @override
  void initState() {
    super.initState();
    controller.resetPartSearch();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Drag Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 10),

            /// Title
            Text(
              "Part Request",
              style: mTextStyle22(
                textColor: theme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            /// Search Field
            TextField(
              controller: searchCtrl,
              autofocus: true,
              onChanged: controller.searchParts,
              decoration: InputDecoration(
                hintText: 'Search part...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// Searched Results
            Obx(() {
              if (controller.rxPartSearchStatus.value == Status.LOADING) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.rxPartSearchStatus.value == Status.ERROR) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    controller.partSearchError.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (controller.partList.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No parts found'),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.partList.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, index) {
                  final Data part = controller.partList[index];

                  debugPrint(part.title!);
                  return ListTile(
                    title: Text(part.title!),
                    trailing: selectedParts.any((e) => e.id == part.id)
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      if (!selectedParts.any((e) => e.id == part.id)) {
                        setState(() {
                          selectedParts.add(part);
                          partQty[part.id!] = 1;
                        });
                        searchCtrl.clear();
                        controller.resetPartSearch();
                      }
                    },
                  );
                },
              );
            }),

            Container(width: double.infinity, height: 1, color: Colors.white),
            const SizedBox(height: 10),

            /// Selected Parts List
            if (selectedParts.isNotEmpty) ...[
              Text(
                'Selected Parts',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: selectedParts.length,
                itemBuilder: (_, index) {
                  final part = selectedParts[index];
                  return ListTile(
                    title: Text(part.title!),
                    trailing: selectedParts.any((e) => e.id == part.id)
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    int currentQty = partQty[part.id] ?? 1;

                                    if (currentQty > 1) {
                                      partQty[part.id!] = currentQty - 1;
                                    } else {
                                      selectedParts.removeWhere(
                                        (e) => e.id == part.id,
                                      );
                                      partQty.remove(part.id);
                                    }
                                  });
                                },
                              ),
                              Text(
                                (partQty[part.id] ?? 1).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    int currentQty = partQty[part.id] ?? 1;
                                    partQty[part.id!] = currentQty + 1;
                                  });
                                },
                              ),
                            ],
                          )
                        : null,
                    onTap: () {
                      if (!selectedParts.any((e) => e.id == part.id)) {
                        setState(() {
                          selectedParts.add(part);
                          partQty[part.id!] = 1;
                        });
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
            ],

            const SizedBox(height: 16),

            /// Remark Field
            TextField(
              controller: remarkCtrl,
              autofocus: true,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                label: Text('Please enter remark here...'),
                //prefixIcon: const Icon(Icons.eighteen_mp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 26),

            RoundButton(
              title: "Submit Request",
              onTap: () async {
                final success = await controller.submitPartRequest(
                  supportCallId: widget.supportCallId,
                  selectedParts: selectedParts,
                  remark: remarkCtrl.text,
                  qtyMap: partQty,
                );
                if (success == true) {
                  /// 🔥 IMPORTANT (instant refresh)
                  await controller.getPartRequestDetails(widget.supportCallId);
                  /// RESET FORM STATE
                  selectedParts.clear();
                  partQty.clear();
                  searchCtrl.clear();
                  remarkCtrl.clear();
                  controller.resetPartSearch();
                  setState(() {});

                  Get.back(result: true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedCategoryId = Rxn<int>();

  void changeIndex(int index, {int? categoryId}) {
    selectedIndex.value = index;
    if (categoryId != null) {
      selectedCategoryId.value = categoryId;
    }
  }
}

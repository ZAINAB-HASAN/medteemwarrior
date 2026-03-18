import 'package:get/get.dart';
import 'package:med_teem_app/controllers/auth_controllers/profile_controller.dart';

import '../controllers/home_controllers/call/call_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    /// Why fenix? If controller is deleted then it'll recreated automatically
    /// Global Controllers
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<CallController>(() => CallController(), fenix: true);
  }
}

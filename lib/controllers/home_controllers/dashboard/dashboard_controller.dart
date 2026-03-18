import 'package:get/get.dart';

import '../../../data/preferences/preference.dart';
import '../../../data/response/status.dart';
import '../../../repository/home_repository.dart';

class DashboardController extends GetxController {
  ///----------Api's-----------///
  final _api = HomeRepository();
  final userPreference = UserPreference();

  ///----------Rx Variables-----------///
  final rxRequestStatus = Status.LOADING.obs;

  /// Data
  RxMap dashboardData = {}.obs;

  /// Error
  RxString error = ''.obs;

  ///----------Set List-------------///
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  /// fetch dashboard details
  Future<void> getDashboardData() async {
    setRxRequestStatus(Status.LOADING);
    userPreference.getUser().then((user) {
      _api
          .dashboardApi(user.token)
          .then((response) {
            dashboardData.value = response['data'];
            setRxRequestStatus(Status.COMPLETED);
            print("Dashboard Data: $response");
          })
          .onError((error, stackTrace) {
            setRxRequestStatus(Status.ERROR);
            this.error.value = error.toString();
            print(error);
          });
    });
  }
}

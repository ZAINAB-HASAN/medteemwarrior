import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:med_teem_app/core/utils/custom_snackebar.dart';
import 'package:med_teem_app/models/call_screen_models/searched_part_items.dart';
import '../../../data/preferences/preference.dart';
import '../../../data/response/status.dart';
import '../../../models/call_screen_models/call_model.dart';
import '../../../models/call_screen_models/part_request_details_model.dart';
import '../../../repository/home_repository.dart';

class CallController extends GetxController {
  ///----------Api's-----------///
  final _api = HomeRepository();
  final userPreference = UserPreference();

  ///----------Rx Variables-----------///
  final rxRequestStatus = Status.LOADING.obs;
  final rxPartSearchStatus = Status.COMPLETED.obs;

  RxString error = ''.obs;
  RxString partSearchError = ''.obs;

  ///----------Update Status-----------///
  RxBool updateStatusLoading = false.obs;

  final TextEditingController remarkStatusController = TextEditingController();

  RxString selectedStatus = ''.obs;

  /// API ke according values
  final List<String> statusList = ["open", "inProgress", "resolved", "closed"];

  ///----------Set List-------------///
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setRxPartSearchStatus(Status value) => rxPartSearchStatus.value = value;

  void setError(String _value) => error.value = _value;

  void setPartSearchError(String value) => partSearchError.value = value;

  ///----------Call List-----------///
  final callList = CallModel().obs;

  void setCallList(CallModel _value) => callList.value = _value;

  ///----------Part Request Details List-----------///
  RxList<PartsRequest> partRequestDetailsList = <PartsRequest>[].obs;

  void setPartRequestDetailsList(List<PartsRequest> data) {
    partRequestDetailsList.value = data;
  }

  /*final partRequestList = PartRequestDetailsModel().obs;

  void setPartRequestDetailsList(PartRequestDetailsModel _partReqListModel) =>
      partRequestList.value = _partReqListModel;*/

  ///----------Part Search List-----------///
  final RxList<Data> partList = <Data>[].obs;

  void setPartList(List<Data> value) => partList.assignAll(value);

  ///---------On Init----------///
  @override
  void onInit() {
    getCalls();
    super.onInit();
  }

  ///-----------Fetch Calls------------///
  void getCalls() {
    setRxRequestStatus(Status.LOADING);
    userPreference.getUser().then((value) {
      if (value.token?.isEmpty ?? true) {
        setRxRequestStatus(Status.ERROR);
        return;
      }
      _api
          .getCallsApi(value.token)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setCallList(value);
          })
          .onError((e, stacktrace) {
            setError(e.toString());
            setRxRequestStatus(Status.ERROR);
          });
    });
  }

  ///-----------Search Parts------------///
  void searchParts(String query) {
    if (query.trim().isEmpty) {
      partList.clear();
      rxPartSearchStatus.value = Status.COMPLETED;
      return;
    }

    setRxPartSearchStatus(Status.LOADING);

    userPreference.getUser().then((user) {
      if (user.token?.isEmpty ?? true) {
        setRxPartSearchStatus(Status.ERROR);
        setPartSearchError('Invalid token');
        return;
      }
      _api
          .searchedPartApi(user.token!, {'search': query})
          .then((SearchedPartItems value) {
            setRxPartSearchStatus(Status.COMPLETED);
            setPartList(value.data ?? []);
          })
          .onError((e, _) {
            setPartSearchError(e.toString());
            setRxPartSearchStatus(Status.ERROR);
          });
    });
  }

  /// ----------------partsRequest-------------------
  Future<bool> submitPartRequest({
    required supportCallId,
    required remark,
    required List<Data> selectedParts,
    required Map<int, int> qtyMap,
  }) async {
    final user = await userPreference.getUser();
    String userToken = user.token.toString();
    final Map<String, dynamic> data = {
      "supportCallId": supportCallId,
      "remark": remark,
      "items": selectedParts.map((part) {
        return {"productId": part.id, "requestedQty": qtyMap[part.id] ?? 1};
      }).toList(),
    };
    debugPrint('Part Request Data: $data');
    final response = await _api.partsRequestApi(
      userToken,
      data, // ✅ PASS DATA HERE
    );

    debugPrint('Part Request Response: $response');
    if (response != null && response['action'] == true) {
      Utils.showMsg(response['message'] ?? "Request Submitted");
      return true;
    } else {
      Utils.showMsg(response['message'] ?? "Something went wrong");
      return false;
    }
  }

  /// ----------------partsRequestDetails-------------------
  Future<void> getPartRequestDetails(int id) async {
    setRxRequestStatus(Status.LOADING);

    try {
      final user = await userPreference.getUser();

      if (user.token?.isEmpty ?? true) {
        setRxRequestStatus(Status.ERROR);
        setError("Invalid token");
        return;
      }

      final response = await _api.getPartRequestDetailsApi(user.token!, id);

      setPartRequestDetailsList(response);
      setRxRequestStatus(Status.COMPLETED);
    } catch (e) {
      setError(e.toString());
      setRxRequestStatus(Status.ERROR);
    }
  }

  void resetPartSearch() {
    partList.clear();
    partSearchError.value = '';
    rxPartSearchStatus.value = Status.COMPLETED;
  }

  /// ----------------UPDATE STATUS-------------------
  Future<bool> updateSupportStatus({required int supportCallId}) async {
    if (selectedStatus.value.isEmpty) {
      Utils.showMsg("Please select status");
      return false;
    }

    try {
      updateStatusLoading.value = true;

      final user = await userPreference.getUser();

      var data = {
        "supportCallId": supportCallId.toString(),
        "status": selectedStatus.value,
        "remark": remarkStatusController.text,
      };

      debugPrint("Update Status Data: $data");

      final response = await _api.updateSupportStatusApi(user.token!, data);

      updateStatusLoading.value = false;

      if (response != null && response['success'] == true) {
        Utils.showMsg(response['message'] ?? "Status Updated");

        /// reset fields
        selectedStatus.value = '';
        remarkStatusController.clear();

        /// optional → refresh call list
        getCalls();

        return true;
      } else {
        Utils.showMsg(response['message'] ?? "Something went wrong");
        return false;
      }
    } catch (e) {
      updateStatusLoading.value = false;
      Utils.showMsg(e.toString());
      return false;
    }
  }
}

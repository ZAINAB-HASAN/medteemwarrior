import 'package:med_teem_app/data/network/network_api_services.dart';
import 'package:med_teem_app/models/call_screen_models/searched_part_items.dart';

import '../core/app_urls/app_urls.dart';
import '../models/call_screen_models/call_model.dart';
import '../models/call_screen_models/part_request_details_model.dart';

class HomeRepository {
  final _apiService = NetworkApiService();

  Future<CallModel> getCallsApi(var token) async {
    dynamic response = await _apiService.postApi1(
      {"page": "1", "limit": "10"},
      AppUrl.supportCall,
      {'Authorization': 'Bearer $token'},
    );
    return CallModel.fromJson(response);
  }

  Future<SearchedPartItems> searchedPartApi(var token, var data) async {
    dynamic response = await _apiService.postApi1(data, AppUrl.searchPart, {
      'Authorization': 'Bearer $token',
    });
    return SearchedPartItems.fromJson(response);
  }

  // Future<dynamic> partsRequestApi(var token, var data) async {
  //   dynamic response = await _apiService.postApi1(data, AppUrl.partsRequest, {
  //     'Authorization': 'Bearer $token',
  //   });
  //   return response;
  // }
  Future<dynamic> partsRequestApi(
    String token,
    Map<String, dynamic> data,
  ) async {
    return await _apiService.postApi2(data, AppUrl.partsRequest, {
      'Authorization': 'Bearer $token',
    });
  }

  Future<List<PartsRequest>> getPartRequestDetailsApi(var token, int id) async {
    final url = '${AppUrl.supportCall}/$id';
    final response = await _apiService.getApi1(url, {
      'Authorization': 'Bearer $token',
    });
    final data = response['data'];

    /*if (data == null) {
      return [];
    }*/

    // 🔥 Extract partsRequest from inside data
    final partsRequestList = data['partsRequest'];

    if (partsRequestList is List) {
      return partsRequestList.map((e) => PartsRequest.fromJson(e)).toList();
    }

    return [];
  }

  Future<dynamic> updateSupportStatusApi(var token, var data) async {
    return await _apiService.postApi1(data, AppUrl.updateStatus, {
      'Authorization': 'Bearer $token',
    });
  }

  Future<dynamic> dashboardApi(var token) async {
    return await _apiService.getApi1(AppUrl.dashboard, {
      'Authorization': 'Bearer $token',
    });
  }
}

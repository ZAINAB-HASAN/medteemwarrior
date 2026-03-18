import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../core/app_urls/app_urls.dart';
import '../data/network/network_api_services.dart';

class AuthRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> accountLogin(var data) async {
    return await _apiService.postApi(data, AppUrl.login);
  }

  Future<dynamic> sendOtpApi(var data) async {
    return await _apiService.postApi(data, AppUrl.sendOtp);
  }

  Future<dynamic> verifyOtpApi(var data) async {
    return await _apiService.postApi(data, AppUrl.verifyOtp);
  }

  Future<dynamic> resetPasswordApi(var data) async {
    return await _apiService.postApi(data, AppUrl.resetPassword);
  }

  Future<dynamic> changePasswordApi(var data, var header) async {
    return await _apiService.postApi1(data, AppUrl.changePassword, header);
  }

  Future updateProfileApi({
    required String name,
    required String email,
    required String mobile,
    required String designation,
    required String address,
    File? image,
    var token,
  }) async {
    var request = http.MultipartRequest('PUT', Uri.parse(AppUrl.profileUpdate));

    /// headers
    request.headers.addAll( {'Authorization': 'Bearer $token'});

    /// fields
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['mobileNo'] = mobile;
    request.fields['designation'] = designation;
    request.fields['address'] = address;

    /// image file
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
    print('PUT Request:$request');

    var response = await request.send();

    var responseData = await http.Response.fromStream(response);

    return jsonDecode(responseData.body);

  }
}

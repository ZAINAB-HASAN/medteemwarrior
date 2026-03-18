import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../preferences/preference.dart';
import '../response/app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  UserPreference userPreference = UserPreference();

  ///----------Get APi----------///
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  ///----------Get APi 1----------///
  @override
  Future<dynamic> getApi1(String url, var header) async {
    if (kDebugMode) {
      print('GET Request: $url');
      print('Headers: $header');
    }
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      responseJson = returnResponse(response);
    } on SocketException {
      print('Socket Exception: No Internet connection');
      throw InternetException('');
    } on TimeoutException {
      print('Timeout Exception: Request timed out');
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  ///----------Post APi----------///
  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  ///----------Post APi 1----------///
  @override
  Future<dynamic> postApi1(data, url, header) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data, headers: header)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  ///----------Post API 2----------///
  @override
  Future<dynamic> postApi2(
    Map<String, dynamic> data,
    String url,
    Map<String, String> header,
  ) async {
    if (kDebugMode) {
      print("URL: $url");
      print("BODY: ${jsonEncode(data)}");
    }
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {...header, "Content-Type": "application/json"},
            body: jsonEncode(data), // 🔥 THIS IS THE FIX
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }

    if (kDebugMode) {
      print(responseJson);
    }

    return responseJson;
  }

  ///------------Delete Api----------///
  @override
  Future<dynamic> deleteApi(String url) async {
    if (kDebugMode) {
      print('DELETE: $url');
    }
    dynamic responseJson;
    try {
      final response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  ///-------------Put APi------------///
  @override
  Future<dynamic> putApi(var data, String url) async {
    if (kDebugMode) {
      print("PUT: $url");
      print("BODY: ${jsonEncode(data)}");
    }
    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
          'Error occurred while communicating with server ${response.statusCode}',
        );
    }
  }
}

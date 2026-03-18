import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/call_screen_models/searched_part_items.dart';
import '../../models/user_model/user_model.dart';

class UserPreference {
  Future<bool> saveUser(UserModel responseModel) async {
    SharedPreferences appSp = await SharedPreferences.getInstance();

    appSp.setInt('id', responseModel.id ?? 0);
    appSp.setString('employeeId', responseModel.employeeId ?? '');
    appSp.setString('fullName', responseModel.fullName ?? '');
    appSp.setString('email', responseModel.email ?? '');
    appSp.setString('mobileNo', responseModel.mobileNo ?? '');
    appSp.setString('contact', responseModel.contact ?? '');
    appSp.setString('image', responseModel.image ?? '');
    appSp.setString('address', responseModel.address ?? '');
    appSp.setString('designation', responseModel.designation ?? '');
    appSp.setString('token', responseModel.token ?? '');
    appSp.setBool('isLogin', responseModel.isLogin ?? false);

    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences appSp = await SharedPreferences.getInstance();

    return UserModel(
      id: appSp.getInt('id'),
      employeeId: appSp.getString('employeeId'),
      fullName: appSp.getString('fullName'),
      email: appSp.getString('email'),
      mobileNo: appSp.getString('mobileNo'),
      contact: appSp.getString('contact'),
      image: appSp.getString('image'),
      address: appSp.getString('address'),
      designation: appSp.getString('designation'),
      token: appSp.getString('token'),
      isLogin: appSp.getBool('isLogin'),
    );
  }

  /// Remove stored user
  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    Get.delete<UserPreference>();
    return true;
  }

  // SAVE Selected Searched Items
  /*Future<void> saveSelectedParts(List<Data> parts,Map<int, int> qtyMap) async {
    final sp = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> encodedList = parts.map((part) {
      return {
        "id": part.id,
        "title": part.title,
        "qty": qtyMap[part.id] ?? 1,
      };
    }).toList();
    await sp.setString('selected_parts', jsonEncode(encodedList));
  }

  // LOAD Selected Searched Items
  Future<Map<String, dynamic>> getSelectedParts() async {
    final sp = await SharedPreferences.getInstance();
    final data = sp.getString('selected_parts');

    if (data == null) {
      return {"parts": <Data>[], "qty": <int, int>{}};
    }

    final List decoded = jsonDecode(data);

    List<Data> parts = [];
    Map<int, int> qtyMap = {};

    for (var item in decoded) {
      parts.add(
        Data(
          id: item['id'],
          title: item['title'],
        ),
      );

      qtyMap[item['id']] = item['qty'];
    }

    return {"parts": parts, "qty": qtyMap};
  }


  // CLEAR
  Future<void> clearSelectedParts() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('selected_parts');
  }*/
}

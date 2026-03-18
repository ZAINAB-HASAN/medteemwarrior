import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/preferences/preference.dart';
import '../../models/user_model/user_model.dart';
import '../../repository/auth_repository.dart';

class ProfileController extends GetxController {
  final AuthRepository _api = AuthRepository();
  final UserPreference userPreference = UserPreference();

  /// UI States
  final isEditing = false.obs;
  final isUpdated = false.obs;
  final isLoading = false.obs;

  /// User Data
  Rx<UserModel> user = UserModel().obs;

  /// Image
  final Rxn<File> imageFile = Rxn<File>();

  final ImagePicker _picker = ImagePicker();

  /// Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadLocalUser();
  }

  /// LOAD USER FROM LOCAL STORAGE
  Future<void> loadLocalUser() async {
    try {
      isLoading.value = true;

      final localUser = await userPreference.getUser();

      if (localUser != null) {
        user.value = localUser;

        /// Prefill Controllers
        nameController.text = localUser.fullName ?? "";
        mobileController.text = localUser.mobileNo ?? "";
        emailController.text = localUser.email ?? "";
        designationController.text = localUser.designation ?? "";
        addressController.text = localUser.address ?? "";
        /// IMAGE HANDLING
        if (localUser.image != null && localUser.image!.isNotEmpty) {
          /// Agar path device storage ka hai tabhi File banaye
          if (localUser.image!.startsWith("/") ||
              localUser.image!.startsWith("file://")) {
            imageFile.value = File(localUser.image!);
          } else {
            /// Server path hai (upload/company/...)
            imageFile.value = null;
          }
        } else {
          imageFile.value = null;
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// TOGGLE EDIT MODE
  void toggleEdit() {
    isEditing.value = !isEditing.value;

    if (!isEditing.value) {
      isUpdated.value = false;
    }
  }

  /// FIELD CHANGE DETECTION
  void onFieldChanged() {
    if (isEditing.value) {
      isUpdated.value = true;
    }
  }

  /// PICK IMAGE
  Future<void> pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      imageFile.value = File(picked.path);

      isUpdated.value = true;
    }
  }

  /// UPDATE PROFILE (MULTIPART)
  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final response = await _api.updateProfileApi(
        name: nameController.text,
        email: emailController.text,
        mobile: mobileController.text,
        designation: designationController.text,
        address: addressController.text,
        image: imageFile.value,
        token: user.value.token ?? "",
      );

      print('Profile Controller response: $response');
      if (response['action'] == true) {
        /// Update local model
        user.value.fullName = nameController.text;
        user.value.mobileNo = mobileController.text;
        user.value.email = emailController.text;
        user.value.designation = designationController.text;
        user.value.address = addressController.text;

        /// update image only if picked
        if (imageFile.value != null) {
          user.value.image = imageFile.value!.path;
        }

        /// Save updated user locally
        await userPreference.saveUser(user.value);

        isEditing.value = false;
        isUpdated.value = false;

        Get.snackbar(
          "Success",
          response['message'] ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
        );
        print('response message: ${response['message']}');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      print('Error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    designationController.dispose();
    addressController.dispose();

    super.onClose();
  }
}

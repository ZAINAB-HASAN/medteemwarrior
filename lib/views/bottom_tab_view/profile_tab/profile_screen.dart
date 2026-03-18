import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_teem_app/core/app_urls/app_urls.dart';

import '../../../controllers/auth_controllers/profile_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isEditing.value ? Icons.close : Icons.edit,
                color: AppColors.appColor,
              ),
              onPressed: controller.toggleEdit,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Stack(
          children: [
            /// Profile Content
            Obx(() {
              final user = controller.user.value;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                child: Column(
                  children: [
                    /// HEADER
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top:0.5),
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff1565C0), Color(0xff5E8BFF)],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                      ),
                      child: Column(
                        children: [
                          /// PROFILE IMAGE
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.grey.shade200,
                                child: ClipOval(
                                  child: controller.imageFile.value != null
                                      ? Image.file(
                                    controller.imageFile.value!,
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  )
                                      : (user.image != null && user.image!.isNotEmpty)
                                      ? Image.network(
                                    "${AppUrl.baseImageUrl}/${user.image!.replaceAll('\\', '/')}",
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.person, size: 50);
                                    },
                                  )
                                      : const Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                ),
                              ),
                              /// CAMERA ICON
                              if (controller.isEditing.value)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: controller.pickImage,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: AppColors.appColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Text(
                            user.fullName ?? "",
                            style: mTextStyle20(
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            user.email ?? "",
                            style: mTextStyle18(textColor: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// NAME FIELD
                    _profileField(
                      "Full Name",
                      controller.nameController,
                      Icons.person_outline,
                      controller.isEditing.value,
                    ),

                    /// MOBILE FIELD
                    _profileField(
                      "Mobile Number",
                      controller.mobileController,
                      Icons.phone_iphone,
                      controller.isEditing.value,
                    ),

                    /// DESIGNATION
                    _profileField(
                      "Designation",
                      controller.designationController,
                      Icons.business_center,
                      controller.isEditing.value,
                    ),

                    /// ADDRESS
                    _profileField(
                      "Address",
                      controller.addressController,
                      Icons.location_on_outlined,
                      controller.isEditing.value,
                      maxLines: 2,
                    ),
                  ],
                ),
              );
            }),

            /// UPDATE BUTTON
            Obx(() {
              if (!controller.isUpdated.value) {
                return const SizedBox();
              }

              return Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: ElevatedButton(
                  onPressed: controller.updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Update Profile",
                          style: mTextStyle20(
                            textColor: AppColors.appWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _profileField(
    String title,
    TextEditingController controller,
    IconData icon,
    bool enabled, {
    int maxLines = 1,
  }) {
    final ProfileController profileController = Get.find();
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          style: mTextStyle17(),
          onChanged: (value) {
            profileController.onFieldChanged();
          },
          decoration: InputDecoration(
            labelText: title,
            labelStyle: mTextStyle16(),
            //border: InputBorder.none,
            border: enabled
                ? OutlineInputBorder()
                : null,
            prefixIcon: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: enabled
                    ? Border.all(
                  color: AppColors.appBlack,
                  width: 2,
                )
                    : null,
              ),
              child: Icon(icon, color: AppColors.appBlack),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(title: Text(title), subtitle: Text(value)),
    );
  }
}

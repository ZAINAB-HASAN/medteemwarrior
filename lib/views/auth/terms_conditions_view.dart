import 'package:flutter/material.dart';
import 'package:med_teem_app/core/theme/app_colors.dart';
import 'package:med_teem_app/core/theme/app_text_style.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.appWhite),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.appWhite,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Terms & Conditions',
          style: mTextStyle18(
            textColor: AppColors.appWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.appColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.appColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.appColor,
                    size: 30,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      'Please read these terms carefully before using the Med Teem Hospital Management System.',
                      style: mTextStyle12(
                        textColor: AppColors.appBlack,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            section(
              Icons.inventory_2_outlined,
              '1. Overview',
              'Welcome to Med Teem, the comprehensive Hospital Inventory and Management System. By accessing this app, employees and staff members agree to comply with our protocols for inventory tracking, medicine management, and medical equipment handling.',
            ),

            section(
              Icons.badge_outlined,
              '2. Employee Responsibility',
              'As a Med Teem authorized user, you are responsible for the accuracy of inventory logs, stock updates, and equipment status reports. Any misuse or intentional falsification of medical records is strictly prohibited.',
            ),

            section(
              Icons.medical_services_outlined,
              '3. Product & Stock Management',
              'All medical products, drugs, and equipment must be handled according to hospital safety standards. Changes in stock levels (Add/Remove/Update) must be recorded in real-time to ensure patient safety and proper supply chain operation.',
            ),

            section(
              Icons.security_outlined,
              '4. Data Confidentiality',
              'Hospital inventory data, including supplier details and stock costs, are strictly confidential. Sharing internal data with unauthorized parties is a violation of hospital policy.',
            ),

            section(
              Icons.key_outlined,
              '5. Account Security',
              'Your login credentials are for your personal use only. You must notify hospital IT immediately if you suspect any unauthorized access to your account.',
            ),

            section(
              Icons.business_center_outlined,
              '6. System Usage',
              'Med Teem is to be used solely for official hospital business. Personal use of the inventory management features for non-hospital purposes is not allowed.',
            ),

            SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.security_outlined,
                    color: AppColors.appColor,
                    size: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Verified Med Teem Software',
                    style: mTextStyle14(
                      textColor: AppColors.appColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: mTextStyle12(textColor: AppColors.appGray),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget section(IconData icon, String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.appColor, size: 20),
              SizedBox(width: 10),
              Text(
                title,
                style: mTextStyle14(
                  textColor: AppColors.appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: mTextStyle12(
              textColor: AppColors.appBlack.withOpacity(0.7),
            ).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

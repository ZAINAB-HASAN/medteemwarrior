import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/bottom_tab_view/calls_tab/call/call_screen.dart';
import '../../views/bottom_tab_view/dashboard_tab/dashboard_screen.dart';
import '../../views/bottom_tab_view/orders_tab/orders_screen.dart';
import '../../views/bottom_tab_view/profile_tab/profile_screen.dart';
import '../theme/app_colors.dart';
import 'bottom_nav_controller.dart';

class CustomBottomNavbar extends StatelessWidget {
  CustomBottomNavbar({super.key});

  final navController = Get.put(BottomNavController());

  final List<Map<String, dynamic>> navItems = [
    {
      'icon': Icons.dashboard_outlined,
      'active': Icons.dashboard,
      'label': 'Dash',
    },
    {'icon': Icons.phone_outlined, 'active': Icons.phone, 'label': 'Calls'},
    /*{
      'icon': Icons.shopping_bag_outlined,
      'active': Icons.shopping_bag,
      'label': 'Orders',
    },*/
    {'icon': Icons.person_outline, 'active': Icons.person, 'label': 'Profile'},
  ];

  final List<Widget> screens = [
    DashboardScreen(),
    CallsScreen(),
    //OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navController.selectedIndex.value != 0) {
          navController.changeIndex(0);
          return false;
        }
        return true;
      },
      child: Obx(
        () => Scaffold(
          //body: screens[navController.selectedIndex.value],
          //extendBody: true,
          /// STATE PRESERVE
          body: IndexedStack(
            index: navController.selectedIndex.value,
            children: screens,
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.appWhite,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.appColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navItems.length, (index) {
                bool isActive = navController.selectedIndex.value == index;
                return GestureDetector(
                  onTap: () => navController.changeIndex(index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.appColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      isActive
                          ? navItems[index]['active']
                          : navItems[index]['icon'],
                      color: isActive ? AppColors.appWhite : AppColors.appGray,
                      size: 26,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationClientMenu extends StatelessWidget {
  const NavigationClientMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? SColors.black : SColors.white,
          indicatorColor: darkMode ? SColors.white.withOpacity(0.1) : SColors.black.withOpacity(0.1),
          destinations: 
          const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Lawyer'),
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Profile'),
            ]
            ),
      ),
          body: Obx( () => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [Container()];
}

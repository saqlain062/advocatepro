
import 'package:advocatepro_f/screens/authenticate/screens/signin/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  /// Variables
  final pageController = PageController();
  Rx<int> currentPageIndex= 0.obs;

  /// Update Current Index when Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Jump to the specific dot selected page
  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Update Current Index & jump to next page
  void nextPage(){
    if(currentPageIndex.value == 3){
      final storage = GetStorage();
      storage.write("IsFirstTime", false);
      
      if(kDebugMode){
      print("=================== GET STORAGE Auth Repo =====================================");
      print(storage.read("IsFirstTime"));
    }
      Get.offAll(const SignIn());
    } else {
      int page = currentPageIndex.value+1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage(){
    Get.offAll(const SignIn());
  }
}
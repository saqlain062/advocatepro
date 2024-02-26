
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  /// Variable
  final firstName = TextEditingController(); // controller for First Name
  final email = TextEditingController();
  final phone = TextEditingController();
  final lastName = TextEditingController();
  final doB = TextEditingController();
  final password = TextEditingController();
  final barID = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for form validation

  /// -- SIGNUP
  Future<void> signup() async {
    // Start Loading
    SFullScreenLoader.openLoadingDialog("We are processing your information...", SImages.loadingImage1);

    // Check Internet Connectivity


  }
}
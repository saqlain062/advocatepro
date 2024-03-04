
import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/features/authenticate/screens/password_configuration/reset_password.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/helpers/network_manager.dart';
import 'package:advocatepro_f/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password EMail
  sendPasswordRestEmail() async {
    try {
       /// Start Loading
      SFullScreenLoader.openLoadingDialog(
          "We are processing your information...", SImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordRestEmail(email.text.trim());

      // Remove Loader
        SFullScreenLoader.stopLoading();

      // Show Success Screen
      SLoaders.successSnackBar(title: "Email Sent",message: 'Email Link Sent to Reset your Password'.tr);

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
        // Remove Loader
        SFullScreenLoader.stopLoading();
        SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      
    }
  }
  resendPasswordResetEmail(String email) async {
     try {
       /// Start Loading
      SFullScreenLoader.openLoadingDialog(
          "We are processing your information...", SImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordRestEmail(email);

      // Remove Loader
        SFullScreenLoader.stopLoading();

      // Show Success Screen
      SLoaders.successSnackBar(title: "Email Sent",message: 'Email Link Sent to Reset your Password'.tr);

    } catch (e) {
        // Remove Loader
        SFullScreenLoader.stopLoading();
        SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      
    }
  }
}
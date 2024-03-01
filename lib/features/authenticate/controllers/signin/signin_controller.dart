
import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/helpers/network_manager.dart';
import 'package:advocatepro_f/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SigninController extends GetxController{
  /// Variabler
  final rememberMe = false.obs;
  final hidePassword = false.obs;
  final locatStroage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signinFormkey = GlobalKey<FormState>();

  @override
  void onInit(){
    email.text = locatStroage.read('REMEMBER_ME_EMAIL');
    password.text = locatStroage.read('REMEMBER_ME_PASSWORD');
    super.onInit();
  }

  /// -- Email and Password SignIn
  void emailAndPasswordSignIn() async {
    try {
      /// Start Loading
      SFullScreenLoader.openLoadingDialog(
          "We are processing your information...", SImages.onBoardingImage1);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
      SFullScreenLoader.stopLoading();
        return;
      }
      /// Form Validation
      if (!signinFormkey.currentState!.validate()){
        // Remove Loader
      SFullScreenLoader.stopLoading();
      return;
      } 

      // Save Data if Remember Me is selected
      if(rememberMe.value){
        locatStroage.write('REMEMBER_ME_EMAIL', email.text.trim());
        locatStroage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

     
      // Login user using Email & Password Authentication
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Remove Loader
      SFullScreenLoader.stopLoading();
      
      // Remove Loader
      SFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
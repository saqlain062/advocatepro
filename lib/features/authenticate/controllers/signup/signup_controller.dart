import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/data/repositories/user/user_repository.dart';
import 'package:advocatepro_f/models/user/user_model.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/verify_email.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/helpers/network_manager.dart';
import 'package:advocatepro_f/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variable
  final hidePassword = true.obs; // Observable for hiding/showing password
  final privacyPolicy = false.obs; // Observable for privacy policy acceptance
  final checkLawyer = false.obs; // Observable for lawyer id
  final firstName = TextEditingController(); // controller for First Name
  final email = TextEditingController();
  final phone = TextEditingController();
  final lastName = TextEditingController();
  final doB = TextEditingController();
  final password = TextEditingController();
  final barID = TextEditingController();
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // Form key for form validation

  /// -- SIGNUP
  void signup() async {
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
      if (!signupFormKey.currentState!.validate()){
        // Remove Loader
      SFullScreenLoader.stopLoading();
      return;
      } 

      /// Privacy Policy Check
      if (!privacyPolicy.value) {
        SLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message:
                "In order to create account, you must have to read and accept the privacy Policey & Terms of User");
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newuser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: '',
          email: email.text.trim(),
          phoneNumber: phone.text.trim(),
          profilePicture: '',
          barID: barID.text.trim(),
          pass: password.text.trim());

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newuser);

      // Remove Loader
      SFullScreenLoader.stopLoading();
      // Show Success Message
      SLoaders.successSnackBar(title: "Congratulations", message: "Your account has been created! Verify email to continue.");

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      // Remove Loader
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}

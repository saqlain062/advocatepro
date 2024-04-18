import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/user/user_repository.dart';
import 'package:advocatepro_f/features/personalization/controllers/user_controller.dart';
import 'package:advocatepro_f/features/personalization/screens/profile/profile.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/helpers/network_manager.dart';
import 'package:advocatepro_f/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit(){
    initializeName();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      SFullScreenLoader.openLoadingDialog('We are updating your information...', SImages.onBoardingImage2);
      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
      SFullScreenLoader.stopLoading();
        return;
      }
      /// Form Validation
      if (!updateUserNameFormKey.currentState!.validate()){
        // Remove Loader
      SFullScreenLoader.stopLoading();
      return;
      } 

      // Update user's first & last name in the Firebase Firestore
      Map<String,dynamic> name = {'FirstName': firstName.text.trim(), 'LastName' : lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      SFullScreenLoader.stopLoading();
      // Show Success Message
      SLoaders.successSnackBar(title: "Congratulations", message: "Your Name has beeb updated.");

      // Move to previous screen.
      Get.to(() => const ProfileScreen());
    } catch (e) {
      // Remove Loader
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
  
}
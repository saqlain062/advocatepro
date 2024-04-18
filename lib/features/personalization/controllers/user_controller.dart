import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/data/repositories/user/user_repository.dart';
import 'package:advocatepro_f/features/authenticate/screens/signin/sign_in.dart';
import 'package:advocatepro_f/features/personalization/models/user_model.dart';
import 'package:advocatepro_f/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/network_manager.dart';
import 'package:advocatepro_f/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUplodaing = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First Update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // if no record already stored.
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // Conver Name to First and Last Name
          final namePart =
              UserModel.nameParts(userCredential.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredential.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
              id: userCredential.user!.uid,
              firstName: namePart[0],
              lastName:
                  namePart.length > 1 ? namePart.sublist(1).join(' ') : '',
              username: username,
              email: userCredential.user!.email ?? '',
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '',
              barID: '',
              pass: '');

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      SLoaders.warningSnackBar(
          title: "Data not Saved",
          message:
              'Something went wrong while saving your information. You can re-save data in your Profile.');
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSizes.medium),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to deleteyour account permanently? This action is not reversible and all your data removed permanently.',
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: SSizes.large),
            child: Text('Delete'),
          )),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel')),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Processing', SImages.onBoardingImage2);

      // First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.siginWithGoogle();
          await auth.deleteAccount();
          SFullScreenLoader.stopLoading();
          Get.offAll(() => const SignIn());
        } else if (provider == 'password') {
          SFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- Re-authenticate before deleting
  void reAuthenticateEmailAndPasswordUser() async {
    try {
      /// Start Loading
      SFullScreenLoader.openLoadingDialog(
          "We are processing your information...", SImages.onBoardingImage4);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        // Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateEmailAndPasswordUser(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      // Remove Loader
      SFullScreenLoader.stopLoading();
      Get.offAll(() => const SignIn());
    } catch (e) {
      // Remove Loader
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// Upload Profile Image
  void uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
    if(image != null){
      imageUplodaing.value = true;
      final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

      // update User Image Record
      Map<String, dynamic> json = {'ProfilePicture' : imageUrl};
      await userRepository.updateSingleField(json);

      user.value.profilePicture = imageUrl;
      user.refresh();
      SLoaders.successSnackBar(title: 'Congratulations', message: 'Your Porfile Image has been updated!');

    }
    } catch (e) {
      SLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }finally {
      imageUplodaing.value = false;
    }
    
  }

}



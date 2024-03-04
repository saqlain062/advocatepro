import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/user/user_repository.dart';
import 'package:advocatepro_f/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        // Conver Name to First and Last Name
        final namePart =
            UserModel.nameParts(userCredential.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(userCredential.user!.displayName ?? '');

        // Map Data
        final user = UserModel(
            id: userCredential.user!.uid,
            firstName: namePart[0],
            lastName: namePart.length > 1 ? namePart.sublist(1).join(' ') : '',
            username: username,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
            barID: '',
            pass: '');

        // Save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      SLoaders.warningSnackBar(
          title: "Data not Saved",
          message:
              'Something went wrong while saving your information. You can re-save data in your Profile.');
    }
  }
}

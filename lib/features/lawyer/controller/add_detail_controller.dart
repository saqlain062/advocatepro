import 'package:advocatepro_f/features/client/models/agency_model.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/features/home/home_client_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

class AddDetailController extends GetxController {
  final name = TextEditingController();
  final description = TextEditingController();
  final specialization = TextEditingController();
  final agencyId = TextEditingController();
  final lawyerAgencyId = TextEditingController();
  final agencyName = TextEditingController();
  var specValue = '';
  final photoURL = ''.obs;
  final photoUrls = [].obs;
  final imageUplodaing = false.obs;
  final checkAgency = false.obs;
  var selectedSpecialization = ''.obs;
  List<String> specializationOptions = [
    'Corporate Law',
    'Criminal Law',
    'Family Law',
    'Real Estate Law',
    'Labor and Employment Law',
    'Intellectual Property Law',
    'Environmental Law',
    'Banking and Finance Law',
    'Healthcare Law',
    'Immigration Law',
    'Tax Law',
    'Personal Injury Law',
    'Civil Rights Law',
    'Entertainment Law',
    'International Law',
    'Constitutional Law',
    'Admiralty (Maritime) Law',
    'Aviation Law',
    'Elder Law',
    'Military Law',
    'Education Law',
    'Sports Law',
    'Trusts and Estates Law',
    'Alternative Dispute Resolution (Arbitration and Mediation)',
    'Cybersecurity and Privacy Law',
    'Animal Law',
    'Insurance Law',
    'Energy Law',
    'Securities Law',
    'Government Law (Administrative and Regulatory Law)',
    'Indigenous (Native American) Law',
    'Technology Law (Tech Law)',
    'Antitrust Law',
    'Construction Law',
    'Gaming Law',
    'Space Law',
    'Art Law',
    'Fashion Law',
    'Food and Drug Law',
    'International Trade Law'
  ];
  GlobalKey<FormState> addDetailForm = GlobalKey<FormState>();

  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    specialization.text = selectedSpecialization.value;
  }

  void onSpecializationChanged(String? newValue) {
    selectedSpecialization.value = newValue ?? '';
    // specValue = specializationOptions.indexOf(specialization.text) as String;
  }

  /// -- uploadDetail
  void uploadDetail() async {
    try {
      /// Start Loading
      SFullScreenLoader.openLoadingDialog(
          "We are uploading your information...", SImages.onBoardingImage1);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }

      // Save user data in the Firebase Firestore
      final newuserDetail = LawyerModel(
          id: uid() ?? '',
          title: name.text.trim(),
          spec: selectedSpecialization.value,
          thumbnail: photoURL.value,
          agency: AgencyModel(
              id: agencyId.text.trim(),
              name: agencyName.text.trim(),
              image: '',
              isFeatured: checkAgency.value,
              lawyersCounts: int.tryParse(lawyerAgencyId.text) ?? 0),
          categoryId: selectedSpecialization.value,
          date: DateTime.now(),
          description: description.text,
          images: photoUrls.map((url) => url.toString()).toList(),
          isFeatured: true);

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord("Lawyers", newuserDetail);

      // Remove Loader
      SFullScreenLoader.stopLoading();
      // Show Success Message
      SLoaders.successSnackBar(
          title: "Congratulations", message: "Your detail uploaded.");
    } catch (e) {
      // Remove Loader
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// Upload Profile Image
  void uploadPicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUplodaing.value = true;
        final imageUrl = await userRepository.uploadImage(
            'Users/${AuthenticationRepository.instance.authUser!.uid}/Images/Profile/',
            image);

      

        // update User Image Record
        // Map<String, dynamic> json = {'Images': imageUrl};
        // await userRepository.updateSingleField('Lawyers', json);

        photoURL.value = imageUrl;
        photoUrls.add(imageUrl);
        photoUrls.refresh();
        print('----------------$photoURL');
        photoURL.refresh();
      }
    } catch (e) {
      SLoaders.errorSnackBar(
          title: 'OhSnap', message: 'Something went wrong: $e');
    } finally {
      imageUplodaing.value = false;
    }
  }
}

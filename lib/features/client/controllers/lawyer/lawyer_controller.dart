import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/lawyer/lawyer_repository.dart';

class LawyerController extends GetxController {
  static LawyerController get instance => Get.find();

  final isLoading = false.obs;
  final lawyerRepository = Get.put(LawyerRepository());
  RxList<LawyerModel> featuredLawyer = <LawyerModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedLawyers();
    super.onInit();
  }

  void fetchFeaturedLawyers() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Lawyers
      final lawyer = await lawyerRepository.getFeaturedLawyers();

      // Assign Lawyers
      featuredLawyer.assignAll(lawyer);
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap! L', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<LawyerModel>> fetchAllFeaturedLawyers() async {
    try {
      // Fetch Lawyers
      final lawyer = await lawyerRepository.getFeaturedLawyers();
      return lawyer;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap! L', message: e.toString());
      return [];
    } 
  }
}

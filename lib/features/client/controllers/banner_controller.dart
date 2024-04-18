
import 'package:advocatepro_f/data/repositories/banners/banner_repository.dart';
import 'package:advocatepro_f/features/client/models/banner_model.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';

class BannerController extends GetxController {
  
  /// Variabler
  final isLoading = false.obs;
  final carousaelCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }
  /// Update Page Navigational Dots
  void updatePageIndicator(index){
    carousaelCurrentIndex.value = index;  
  }


  /// Fetch Banner
  Future<void> fetchBanners() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch Banner 
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);

      
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap c!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
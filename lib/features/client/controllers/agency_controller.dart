import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/lawyer/lawyer_repository.dart';
import 'package:advocatepro_f/features/client/models/agency_model.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:get/get.dart';
import '../../../data/repositories/agencies/agency_repository.dart';

class AgencyController extends GetxController {
  static AgencyController get instance => Get.find();

  final isLoading = true.obs;
  final RxList<AgencyModel> allAgencies = <AgencyModel>[].obs;
  final RxList<AgencyModel> featuredAgencies = <AgencyModel>[].obs;
  final agenyRepository = Get.put(AgencyRepository());

  @override
  void onInit() {
    getFeaturedAgencies();
    super.onInit();
  }

  /// Load Agency
  Future<void> getFeaturedAgencies() async {
    try {
      isLoading.value = true;

      final agencies = await agenyRepository.getAllAgencies();

      allAgencies.assignAll(agencies);

      featuredAgencies.assignAll(allAgencies.where((agency) => agency.isFeatured ?? false).take(4));

    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  /// Get Agency for category
  Future<List<AgencyModel>> getAgencyForCategory(String categoryId) async {
    try {
      final agency = await agenyRepository.getAgencyForCategory(categoryId);
      return agency;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
      return [];
    }
  }

  /// Get Agency Specific Lawyers from data source
  Future<List<LawyerModel>> getAgencyLawyers({required String agencyId, int limit=-1 }) async {
    try {
      final lawyer = await LawyerRepository.instance.getLawyersForAgency(agencyId:agencyId, limit: limit);
      return lawyer;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
      return [];
    }
  }
}
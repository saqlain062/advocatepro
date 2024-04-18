import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/lawyer/lawyer_repository.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllLawyersController extends GetxController {
  static AllLawyersController get instance => Get.find();

  final repository = LawyerRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<LawyerModel> lawyer = <LawyerModel>[].obs;

  Future<List<LawyerModel>> fetchLawyersByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final lawyers = await repository.getLawyerByQuery(query);
      return lawyers;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortLawyers(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        lawyer.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Newest':
        lawyer.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      default:
        lawyer.sort((a, b) => a.title.compareTo(b.title));
        break;
    }
  }

  void assignLawyers(List<LawyerModel> lawyer){
    // Assign lawyers to the 'lawyer' list
    this.lawyer.assignAll(lawyer);
    sortLawyers('Name');
  }
}

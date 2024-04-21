import 'dart:convert';

import 'package:advocatepro_f/common/widgets/loaders/loaders.dart';
import 'package:advocatepro_f/data/repositories/lawyer/lawyer_repository.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  /// Variables
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  //Method to initialize favorites bu reading from storage
  void initFavourites(){
    final json = SLocalStorage.instance().readData("favourites");
    if(json != null){
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }
  
  bool isFavourite(String lawyerId){
    return favourites[lawyerId] ?? false;
  }

  void toggleFavouriteLawyer(String lawyerId){
    if(!favourites.containsKey(lawyerId)){
      favourites[lawyerId] = true;
      saveFavouriteToStorage();
      SLoaders.successSnackBar(title: "Lawyer has been added to the Wishlist.");
    } else {
      SLocalStorage.instance().removeData(lawyerId);
      favourites.remove(lawyerId);
      saveFavouriteToStorage();
      favourites.refresh();
      SLoaders.successSnackBar(title: 'Lawyer has been removed from the wishlish');
    }
  }

  void saveFavouriteToStorage() {
    final encodedFavorites = json.encode(favourites);
    SLocalStorage.instance().saveData('favourites', encodedFavorites);
  }

  Future<List<LawyerModel>> favouriteLawyers() async {
    return await LawyerRepository.instance.getFavouriteLawyers(favourites.keys.toList());
  }
}
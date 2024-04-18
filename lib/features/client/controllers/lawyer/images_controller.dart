import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  /// Variables
  RxString selectedLawyerImage = ''.obs;

  /// Get All Images from product and Variations
  List<String> getAllLawyerImages(LawyerModel lawyer) {
    // Use Set to add unique images only
    Set<String> images = {};

    // Load thumbnail image
    images.add(lawyer.thumbnail);

    // Assign Thumbnail as Selected Image
    selectedLawyerImage.value = lawyer.thumbnail;

    // Get all images from the Product Model if not null
    if(lawyer.images != null){
      images.addAll(lawyer.images!);
    }

    return images.toList();
  }

  /// Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: SSizes.defaultSpaces *2, horizontal: SSizes.defaultSpaces),
            child: CachedNetworkImage(imageUrl: image),),
            const SizedBox(height: SSizes.spaceBetweenSections,),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close'),),
              ),
            )
          ],
        ),
      )
    );
  }
}
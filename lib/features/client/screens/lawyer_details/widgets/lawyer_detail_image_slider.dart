import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:advocatepro_f/common/widgets/images/S_rounded_image.dart';
import 'package:advocatepro_f/common/widgets/lawyers/favourite_icon/favourite_icon.dart';
import 'package:advocatepro_f/features/client/controllers/lawyer/images_controller.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SLawyerImageSlider extends StatelessWidget {
  const SLawyerImageSlider({
    super.key,
    required this.lawyer,
  });

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    final controller = Get.put(ImageController());
    final images = controller.getAllLawyerImages(lawyer);

    return SCurvedEdgeWidget(
        child: Container(
      color: dark ? SColors.darkerGrey : SColors.light,
      child: Stack(
        children: [
          /// Main Large Image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(SSizes.profileImageRadius * 2),
              child: Center(
                child: Obx(() {
                  final image = controller.selectedLawyerImage.value;
                  return GestureDetector(
                    onTap: () => controller.showEnlargedImage(image),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: SColors.primary,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          /// Image Slider
          Positioned(
              right: 0,
              bottom: 30,
              left: SSizes.defaultSpaces,
              child: Padding(
                padding: const EdgeInsets.all(SSizes.defaultSpaces),
                child: SizedBox(
                  height: 68,
                  child: ListView.separated(
                    itemCount: images.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const SizedBox(
                      width: SSizes.spaceBetweenItems,
                    ),
                    itemBuilder: (_, index) => Obx(() {
                      final imageSelected = controller.selectedLawyerImage.value == images[index];
                      return SRoundImage(
                          width: 68,
                          isNetworkImage: true,
                          backgroundColor: dark ? SColors.dark : SColors.white,
                          onPressed: () => controller.selectedLawyerImage.value = images[index],
                          border: Border.all(color: imageSelected ? SColors.primary : Colors.transparent),
                          padding: const EdgeInsets.all(SSizes.small),
                          imageUrl: images[index]);
                    }),
                  ),
                ),
              )),

          /// Appbar Icons
          SAppBar(
            showBackArrow: true,
            actions: [
              SFavouriteIcon(lawyerId: lawyer.id)
            ],
          )
        ],
      ),
    ));
  }
}

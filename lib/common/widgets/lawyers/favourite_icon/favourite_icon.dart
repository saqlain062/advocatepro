import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/client/controllers/lawyer/favourites_controller.dart';
import '../../../icons/S_circular_icon.dart';

class SFavouriteIcon extends StatelessWidget {
  const SFavouriteIcon({super.key, required this.lawyerId});

  final String lawyerId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(() => SCirularIcon(
          icon: controller.isFavourite(lawyerId) ? Iconsax.heart5 : Iconsax.heart,
          color: controller.isFavourite(lawyerId) ? Colors.red : null,
          onPressed: () => controller.toggleFavouriteLawyer(lawyerId),
        ));
  }
}

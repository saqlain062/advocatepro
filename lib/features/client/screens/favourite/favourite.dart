import 'package:advocatepro_f/common/icons/S_circular_icon.dart';
import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card_vertical.dart';
import 'package:advocatepro_f/common/widgets/loaders/animation_loader.dart';
import 'package:advocatepro_f/features/client/controllers/lawyer/favourites_controller.dart';
import 'package:advocatepro_f/navigation_client_menu.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      appBar: SAppBar(
          title: Text(
            'Wishlist',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            SCirularIcon(
              icon: Icons.add,
              onPressed: () => Get.to(const NavigationClientMenu()),
            )
          ]),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(
          children: [
            Obx(
              () =>  FutureBuilder(
                  future: controller.favouriteLawyers(),
                  builder: (context, snapshot) {
                    /// Nothing Found Widget
                    final emptyWidget = SAnimationLoaderWidget(
                        text: 'Whoops! Wishlist is Empty ...',
                        animation: SImages.onBoardingImage3,
                        showAction: true,
                        actionText: 'Let\'s add some',
                        onActionPressed: () =>
                            Get.off(() => const NavigationClientMenu()));
                    final widget = SCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, nothingFound: emptyWidget);
                    if (widget != null) return widget;
              
                    final lawyers = snapshot.data!;
              
                    return SGridLayout(
                        itemCount: lawyers.length,
                        itemBuilder: (_, index) => SlawyerCardVertical(
                              lawyer: lawyers[index],
                            ));
                  }),
            )
          ],
        ),
      )),
    );
  }
}

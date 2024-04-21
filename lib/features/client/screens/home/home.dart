import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:advocatepro_f/common/widgets/custom_shapes/containers/serach_container.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card_vertical.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/controllers/lawyer/lawyer_controller.dart';
import 'package:advocatepro_f/features/client/screens/all_lawyers/all_lawyers.dart';
import 'package:advocatepro_f/features/client/screens/home/widgets/home_appbar.dart';
import 'package:advocatepro_f/features/client/screens/home/widgets/home_categories.dart';
import 'package:advocatepro_f/features/client/screens/home/widgets/promo_slider.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenClient extends StatelessWidget {
  const HomeScreenClient({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          /// Header
          children: [
            const SPrimaryHeaderContainer(
              child: Column(children: [
                /// -- Appbar
                SHomeAppBarClient(),
                SizedBox(
                  height: SSizes.spaceBetweenSections,
                ),

                /// -- Searchbar
                SSearchContainer(text: 'Search'),
                SizedBox(
                  height: SSizes.spaceBetweenSections,
                ),

                /// -- Categories
                Padding(
                  padding: EdgeInsets.only(left: SSizes.defaultSpaces),
                  child: Column(
                    children: [
                      /// -- Heading
                      SSectionHeading(
                        title: 'Popular Categories',
                        showActionButton: false,
                        textColor: SColors.white,
                      ),
                      SizedBox(
                        height: SSizes.spaceBetweenItems,
                      ),

                      /// -- Categories
                      SHomeCategories(),
                      SizedBox(
                        height: SSizes.spaceBetweenSections,
                      ),
                    ],
                  ),
                )
              ]),
            ),

            /// Body
            Padding(
                padding: const EdgeInsets.all(SSizes.defaultSpaces),
                child: Column(
                  children: [
                    /// -- Promo Slider
                    const SPromoSlider(),
                    const SizedBox(
                      height: SSizes.spaceBetweenSections,
                    ),

                    /// Heading
                    SSectionHeading(
                      title: 'Popular Lawyer',
                      onPressed: () => Get.to(() => AllLawyers(title: "Popular Lawyer",futureMethod: controller.fetchAllFeaturedLawyers(),)),
                    ),

                    const SizedBox(
                      height: SSizes.spaceBetweenItems,
                    ),

                    /// -- Popular Advocats
                    Obx(() {
                      if (controller.isLoading.value) return const CircularProgressIndicator();

                      if (controller.featuredLawyer.isEmpty) {
                        return Center(
                          child: Text(
                            'No Data Found!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }
                      return SGridLayout(
                        itemCount: controller.featuredLawyer.length,
                        itemBuilder: (_, index) => SlawyerCardVertical(
                            lawyer: controller.featuredLawyer[index]),
                      );
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class SNotificationCounterIcon extends StatelessWidget {
  const SNotificationCounterIcon({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.notifications_none,
              color: SColors.iconColorin,
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                color: SColors.primary,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: SColors.iconColorin, fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}

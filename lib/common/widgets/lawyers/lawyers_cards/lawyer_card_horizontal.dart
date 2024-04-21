import 'package:advocatepro_f/common/styles/shadoows.dart';
import 'package:advocatepro_f/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:advocatepro_f/common/widgets/images/S_rounded_image.dart';
import 'package:advocatepro_f/common/widgets/lawyers/favourite_icon/favourite_icon.dart';
import 'package:advocatepro_f/common/widgets/texts/lawyer_title_text.dart';
import 'package:advocatepro_f/common/widgets/texts/s_lawyer_name_with_verified_icon.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_details/lawyer_details.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/enums.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SLawyerCardHorizontal extends StatelessWidget {
  const SLawyerCardHorizontal({super.key, required this.lawyer});

  final LawyerModel lawyer;
  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    /// Container with side paddings, color, edges, radius and shadow
    return GestureDetector(
        onTap: () => Get.to(() => LawyerDetailScreen(
              lawyer: lawyer,
            )),
        child: Container(
          width: 310,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              boxShadow: [SShadowStyle.verticallawyerShadow],
              borderRadius: BorderRadius.circular(SSizes.profileImageRadius),
              color: dark ? SColors.darkerGrey : SColors.lightContainer),
          child: Row(
            children: [
              /// Thumbnail
              SRoundedContainer(
                height: 120,
                padding: const EdgeInsets.all(SSizes.small),
                backgroundColor: dark ? SColors.dark : SColors.light,
                child: Stack(
                  children: [
                    /// -- image
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: SRoundImage(
                        imageUrl: lawyer.thumbnail,
                        applyImageRadius: true,
                        isNetworkImage: true,
                      ),
                    ),

                    /// -- New Tag
                    Positioned(
                      top: 12,
                      child: SRoundedContainer(
                        radius: SSizes.smallmedium,
                        backgroundColor: SColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: SSizes.smallmedium,
                            vertical: SSizes.small),
                        child: Text(
                          'New',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: Colors.black),
                        ),
                      ),
                    ),

                    /// Favourite Icon
                    Positioned(top: 0, right: 0, child: SFavouriteIcon(lawyerId: lawyer.id))
                  ],
                ),
              ),

              /// Details
              SizedBox(
                width: 172,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: SSizes.small, left: SSizes.small),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SLawyerNameWithVerifiedIcon(name: lawyer.title),
                          const SizedBox(
                            height: SSizes.spaceBetweenItems / 2,
                          ),
                          SlawyerTitleText(
                            text: lawyer.spec,
                            nameTextSize: TextSizes.small,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

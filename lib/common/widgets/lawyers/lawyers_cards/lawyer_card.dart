
import 'package:advocatepro_f/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/common/widgets/texts/lawyer_title_text.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/enums.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SlawyerCard extends StatelessWidget {
  const SlawyerCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      /// Container Design
      child: SRoundedContainer(
        padding: const EdgeInsets.all(SSizes.small),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(children: [
          /// -- Icon
          Flexible(
            child: SCircularImage(
              isNetworkImage: false,
              image: SImages.darkAppLogo,
              backgroundColor: Colors.transparent,
              overlayColor: SHelperFunctions.isDarkMode(context)
                  ? SColors.white
                  : SColors.dark,
            ),
          ),
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlawyerTitleText(
                  text: "Courte",
                  nameTextSize: TextSizes.large,
                ),
                SlawyerTitleText(
                  text: '200 lawyer',
                  nameTextSize: TextSizes.medium,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

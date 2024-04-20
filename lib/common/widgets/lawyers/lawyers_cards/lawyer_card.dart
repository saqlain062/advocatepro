
import 'package:advocatepro_f/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/common/widgets/texts/lawyer_title_text.dart';
import 'package:advocatepro_f/features/client/models/agency_model.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/enums.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SlawyerCard extends StatelessWidget {
  const SlawyerCard({
    super.key,
    required this.showBorder,
    this.onTap, required this.agency,
  });

  final AgencyModel agency;
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
              isNetworkImage: true,
              image: agency.image,
              backgroundColor: Colors.transparent,
              overlayColor: SHelperFunctions.isDarkMode(context)
                  ? SColors.white
                  : SColors.dark,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlawyerTitleText(
                  text: agency.name,
                  nameTextSize: TextSizes.large,
                ),
                SlawyerTitleText(
                  text: '${agency.lawyersCounts ?? 0} Lawyers',
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

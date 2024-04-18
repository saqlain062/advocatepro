import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/common/widgets/texts/s_lawyer_name_with_verified_icon.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/enums.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class SLawyerMetaData extends StatelessWidget {
  const SLawyerMetaData({super.key, required this.lawyer});

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Row(
          children: [
            SCircularImage(image: lawyer.brand != null ? lawyer.brand!.image : '',
            width: 32,
            height: 32,
            overlayColor: dark ? SColors.white : SColors.black,),
            SLawyerNameWithVerifiedIcon(name: lawyer.title, nameTextSize: TextSizes.medium,)
          ],
        ),

        /// Decription
        const SizedBox(height: SSizes.spaceBetweenItems,),
        const SSectionHeading(title: 'Description',showActionButton: false,),
        const SizedBox(height: SSizes.spaceBetweenItems,),
        ReadMoreText(
          lawyer.description ?? '',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show More',
          trimExpandedText: 'Less',
          moreStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
          lessStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
        )
        
        
      ],
    );
  }
}
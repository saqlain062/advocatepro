import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SVerticalImageText extends StatelessWidget {
  const SVerticalImageText(
      {super.key,
      required this.image,
      required this.title,
      this.textColor = SColors.white,
      this.bacgroundColor = SColors.white,
      this.isNetworkImage = true,
      this.onTap});

  final String image, title;
  final Color textColor;
  final Color? bacgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: SSizes.spaceBetweenItems),
        child: Column(children: [
          /// Circular Icon
          SCircularImage(image: image,
          fit: BoxFit.fitWidth,
          padding: SSizes.smallmedium * 1.4,
          isNetworkImage: isNetworkImage,
          backgroundColor: bacgroundColor,
          overlayColor: SHelperFunctions.isDarkMode(context) ? SColors.light : SColors.dark,),
          
          /// Text
          const SizedBox(height: SSizes.spaceBetweenItems / 2,),
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ]),
      ),
    );
  }
}

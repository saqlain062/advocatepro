import 'package:advocatepro_f/common/widgets/texts/lawyer_title_text.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/enums.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SLawyerNameWithVerifiedIcon extends StatelessWidget {
  const SLawyerNameWithVerifiedIcon({
    super.key,
    required this.name,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = SColors.primary,
    this.textAlign = TextAlign.center,
    this.nameTextSize = TextSizes.small,
  });

  final String name;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes nameTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlawyerTitleText(
          color: iconColor,
          text: name,
          nameTextSize: TextSizes.large,
        ),
        const SizedBox(
          width: SSizes.small,
        ),
        Icon(
          Icons.verified_user_outlined,
          color: iconColor,
          size: SSizes.iconSmall,
        )
      ],
    );
  }
}

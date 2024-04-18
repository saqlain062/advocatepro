import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class SlawyerTitleText extends StatelessWidget {
  const SlawyerTitleText({
    super.key,
    this.color = SColors.black,
    required this.text,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.nameTextSize = TextSizes.small,
  });

  final Color? color;
  final String text;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes nameTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // Check which brandSize is required and set that style.
      style: nameTextSize == TextSizes.small
          ? Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: color)
          : nameTextSize == TextSizes.medium
              ? Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .apply(color: color)
              : nameTextSize == TextSizes.large
                  ? Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: color)
                  : Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: color),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

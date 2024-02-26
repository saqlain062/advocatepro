import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class STermsAndConditionCheckbox extends StatelessWidget {
  const STermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(value: true, onChanged: (value) {}),
        ),
        const SizedBox(
          width: SSizes.spaceBetweenItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${STexts.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: STexts.privacyPolicy,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(
                      color: dark
                          ? SColors.white
                          : SColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark
                          ? SColors.white
                          : SColors.primary)),
          TextSpan(
              text: ' ${STexts.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: STexts.termsOfUse,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(
                      color: dark
                          ? SColors.white
                          : SColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark
                          ? SColors.white
                          : SColors.primary)),
        ]))
      ],
    );
  }
}

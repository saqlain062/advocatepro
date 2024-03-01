import 'package:advocatepro_f/features/authenticate/controllers/signup/signup_controller.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STermsAndConditionCheckbox extends StatelessWidget {
  const STermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(() => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value)),
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

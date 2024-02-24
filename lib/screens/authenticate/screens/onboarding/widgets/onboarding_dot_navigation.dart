import 'package:advocatepro_f/screens/authenticate/controllers.onboarding/onboarding_controller.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/device/device_utility.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = SHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: SDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: SSizes.defaultSpaces,
        child: SmoothPageIndicator(
          count: 4,
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? SColors.light : SColors.dart, dotHeight: 6),
        ));
  }
}
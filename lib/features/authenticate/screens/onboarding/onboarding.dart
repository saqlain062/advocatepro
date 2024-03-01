import 'package:advocatepro_f/features/authenticate/controllers/onboarding/onboarding_controller.dart';
import 'package:advocatepro_f/features/authenticate/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:advocatepro_f/features/authenticate/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:advocatepro_f/features/authenticate/screens/onboarding/widgets/onboarding_page.dart';
import 'package:advocatepro_f/features/authenticate/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: SImages.onBoardingImage1,
                title: STexts.onBoardingTitle1,
                subTitle: STexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage2,
                title: STexts.onBoardingTitle2,
                subTitle: STexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage3,
                title: STexts.onBoardingTitle3,
                subTitle: STexts.onBoardingSubTitle3,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage4,
                title: STexts.onBoardingTitle4,
                subTitle: STexts.onBoardingSubTitle4,
              ),
            ],
          ),

          /// Skip Button
          const OnBoardingSkip(),

          /// Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}




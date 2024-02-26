import 'package:advocatepro_f/common/widgets/success_screen/success_screen.dart';
import 'package:advocatepro_f/screens/authenticate/screens/signin/sign_in.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const SignIn()),
              icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(
          children: [
            ///Image
            Image(
              image: const AssetImage(SImages.verifyImage1),
              width: SHelperFunctions.screenWidth() * 0.6,
            ),
            const SizedBox(
              height: SSizes.spaceBetweenSections,
            ),

            ///Title & SubTitle
            Text(
              STexts.confimeEmail,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: SSizes.spaceBetweenItems,
            ),
            Text(
              "saqlain.asif3344@gmail.com",
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            Text(
              STexts.confimeEmailSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: SSizes.spaceBetweenSections,
            ),

            ///Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => SuccessScreen(
                      image: SImages.verifyImage1,
                      title: STexts.yourAccountCreatedTitle,
                      subTitle: STexts.yourAccountCreatedSubTitle,
                      onPressed: () => Get.to(() => const SignIn()),
                    )),
                child: const Text(STexts.scontinue),
              ),
            ),
            const SizedBox(
              height: SSizes.spaceBetweenItems,
            ),

            ///Buttons
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Text(STexts.resendEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

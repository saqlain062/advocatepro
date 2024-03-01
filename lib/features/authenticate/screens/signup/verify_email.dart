import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/features/authenticate/controllers/signup/verify_email_controller.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String? email;
  const VerifyEmailScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => AuthenticationRepository.instance.logout()),
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
              email ?? "",
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
                onPressed: () => controller.checkEmailVerificationStatus(),
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
                onPressed: () => controller.sendEmailVerification(),
                child: const Text(STexts.resendEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

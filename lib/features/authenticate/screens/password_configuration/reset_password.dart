import 'package:advocatepro_f/features/authenticate/controllers/forget_password/forget_password_controller.dart';
import 'package:advocatepro_f/features/authenticate/screens/signin/sign_in.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(
            SSizes.defaultSpaces,
          ),
          child: Column(
            children: [
              ///Image
            Image(
              image: const AssetImage(SImages.resetImage1),
              width: SHelperFunctions.screenWidth() * 0.6,
            ),
            const SizedBox(
              height: SSizes.spaceBetweenSections,
            ),

            ///Title & SubTitle
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            Text(
              STexts.changeYourPassowrdTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: SSizes.spaceBetweenItems,
            ),
            Text(
              STexts.changeYourPassowrdSubTile,
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
                onPressed: () => Get.offAll(() => const SignIn()),
                child: const Text(STexts.scontinue),
              ),
            ),
            const SizedBox(height: SSizes.spaceBetweenItems,),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                child: const Text(STexts.resendEmail),
              ),
            ),
            ],
              ),
        ),
      ),
    );
  }
}

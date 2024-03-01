import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                onPressed: (){},
                child: const Text(STexts.scontinue),
              ),
            ),
            const SizedBox(height: SSizes.spaceBetweenItems,),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){},
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

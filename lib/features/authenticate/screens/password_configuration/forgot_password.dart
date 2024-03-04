import 'package:advocatepro_f/features/authenticate/controllers/forget_password/forget_password_controller.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String id = 'forget_password';
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ///Title & SubTitle
          Text(
            STexts.forgetPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: SSizes.spaceBetweenItems,
          ),
          Text(
            STexts.forgetPasswordSubTitle,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: SSizes.spaceBetweenSections * 2,
          ),

          /// Text Field
          Form(
            key: controller.forgetPasswordFormKey,
            child: TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  labelText: STexts.email, prefixIcon: Icon(Icons.email_outlined)),
                  validator: (value) => SValidator.checkEmail(value),
            ),
          ),
          const SizedBox(
            height: SSizes.spaceBetweenSections,
          ),

          /// Submit Button
          SizedBox(
            width: double.infinity, child: ElevatedButton(onPressed: () => controller.sendPasswordRestEmail(), child: const Text(STexts.submit))),
        ]),
      ),
    );
  }
}

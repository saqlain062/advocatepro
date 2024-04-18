import 'package:advocatepro_f/features/personalization/controllers/user_controller.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User'),),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(SSizes.defaultSpaces),
        child: Form(
          key: controller.reAuthFormKey,
        child: Padding(
      padding:
          const EdgeInsets.symmetric(vertical: SSizes.spaceBetweenSections),
      child: Column(
        children: [
          /// Email
          TextFormField(
            controller: controller.verifyEmail,
            
            decoration: const InputDecoration(
              labelText: STexts.email,
              hintText: STexts.email,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: SColors.iconColor,
              ),
            ),
            validator: (value) => SValidator.checkEmail(value),
          ),
          const SizedBox(
            height: SSizes.spaceBtwInputFields,
          ),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.verifyPassword,
              
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: STexts.password,
                hintText: STexts.password,
                prefixIcon: const Icon(Icons.lock_open),
                suffixIcon: IconButton(
                  icon: Icon(controller.hidePassword.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                ),
              ),
              validator: (value) =>
                  SValidator.validationEmptyText('Password', value),
            ),
          ),
          const SizedBox(
            height: SSizes.spaceBtwInputFields / 2,
          ),

          //  Login Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller,
              child: const Center(
                child: Text(STexts.signIn),
              ),
            ),
          ),
          const SizedBox(
            height: SSizes.spaceBetweenItems,
          ),
        
        ],
      ),
    )),),
      ),
    );
  }
}
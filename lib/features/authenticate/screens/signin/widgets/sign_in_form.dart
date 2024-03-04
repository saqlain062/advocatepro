import 'package:advocatepro_f/features/authenticate/controllers/signin/signin_controller.dart';
import 'package:advocatepro_f/features/authenticate/screens/password_configuration/forgot_password.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/sign_up.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SigninController());
    return Form(
        child: Padding(
      padding:
          const EdgeInsets.symmetric(vertical: SSizes.spaceBetweenSections),
      child: Column(
        children: [
          /// Email
          TextFormField(
            controller: controller.email,
            
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
              controller: controller.password,
              
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

          // Remember Me & Forgot Password
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            /// Remember Me
            Row(
              children: [
                Obx(() => Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (value) => controller.rememberMe.value =
                        !controller.rememberMe.value)),
                const Text(STexts.rememberMe),
              ],
            ),

            TextButton(
              onPressed: () => Get.offAll(() => const ForgetPasswordScreen()),
              child:
            const Text(
              STexts.forgetPassword,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  // decoration: TextDecoration.underline,
                  color: Colors.blue),
            ),
            )
          ]),
          const SizedBox(
            height: SSizes.spaceBetweenSections,
          ),

          //  Login Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.emailAndPasswordSignIn(),
              child: const Center(
                child: Text(STexts.signIn),
              ),
            ),
          ),
          const SizedBox(
            height: SSizes.spaceBetweenItems,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.to(() => const SignUpScreen()),
              child: const Text(STexts.createAccount),
            ),
          ),
        ],
      ),
    ));
  }
}

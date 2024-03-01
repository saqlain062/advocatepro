import 'package:advocatepro_f/Methods/round_button.dart';
import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/features/authenticate/screens/password_configuration/reset_password.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String id = 'forget_password';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final contorlloremail = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
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
          TextFormField(
            controller: contorlloremail,
            decoration: const InputDecoration(
                labelText: STexts.email, prefixIcon: Icon(Icons.email_outlined)),
          ),
          const SizedBox(
            height: SSizes.spaceBetweenSections,
          ),
          SizedBox(
            width: double.infinity, child: ElevatedButton(onPressed: () => Get.off(() => const ResetPasswordScreen()), child: const Text(STexts.submit))),
          RoundButton(
            title: "Forgot Password",
            onTop: () {
              auth
                  .sendPasswordResetEmail(
                      email: contorlloremail.text.toString())
                  .then((value) {
                showToast(
                    message:
                        "We have sent you email to recover password, please check your password");
              }).onError((error, stackTrace) {
                showToast(message: error.toString());
              });
            },
          ),
        ]),
      ),
    );
  }
}

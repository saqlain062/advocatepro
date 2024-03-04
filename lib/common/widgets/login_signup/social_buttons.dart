import 'package:advocatepro_f/features/authenticate/controllers/signin/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SSocialButtons extends StatelessWidget {
  const SSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SigninController());
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.googleSignIn(),
        child: const Center(
          child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Sign In with Google',
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
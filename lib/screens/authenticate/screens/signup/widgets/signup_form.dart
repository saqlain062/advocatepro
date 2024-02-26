import 'package:advocatepro_f/screens/authenticate/controllers/signup/signup_controller.dart';
import 'package:advocatepro_f/screens/authenticate/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SSignupForm extends StatelessWidget {
  const SSignupForm({
    super.key,
    required this.isPasswordVisible,
  });

  final bool isPasswordVisible;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              // First Name Field
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: STexts.firstName,
                  ),
                  validator: (value) {
                    return SValidator.checkname(value);
                  },
                ),
              ),
              const SizedBox(
                width: SSizes.spaceBtwInputFields,
              ),
              // Second Name Field
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: STexts.lastName,
                  ),
                  validator: (value) {
                    return SValidator.checkname(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: SSizes.spaceBtwInputFields,
          ),
          // check box
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     SizedBox(
          //       height: 24,
          //       width: 24,
          //       child: Checkbox(
          //           checkColor: Colors.white,
          //           activeColor: SColors.primary,
          //           value: isChecked,
          //           onChanged: (value) {
          //             setState(() {
          //               isChecked = value ?? false;
          //             });
          //           }),
          //     ),
          //     const SizedBox( width: SSizes.spaceBetweenItems,),
          //     Text(
          //       STexts.signupLawyerText,
          //       style: Theme.of(context).textTheme.bodyMedium,
          //     ),
          //   ],
          // ),
          // if (isChecked)
          //   const SizedBox(
          //     height: SSizes.spaceBtwInputFields,
          //   ),
          // if (isChecked)

          ///Bar Number
          TextFormField(
            // onChanged: (value) {
            //   setState(() {
            //     lawyerID = value;
            //   });
            // },
            controller: controller.barID,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_pin_rounded),
              labelText: STexts.barNumber,
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              return SValidator.checkDigits(value);
            }
          ),
          const SizedBox(
            height: SSizes.spaceBtwInputFields,
          ),
          //Email Field
          TextFormField(
            controller: controller.email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: STexts.email,
            ),
            validator: (value) {
              return SValidator.checkEmail(value);
            },
          ),
          const SizedBox(
            height: SSizes.spaceBtwInputFields,
          ),
          // Date of Birth field
          // TextFormField(
          //   readOnly: true,
          //   onTap: () =>
          //     calender(context),
          //   controller: controllerDoB,
          //   decoration: InputDecoration(
          //       prefixIcon: const Icon(Icons.calendar_month),
          //       label: const Text('DOB'),
          //       hintText: 'Enter your Date of Birth',
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           borderSide: const BorderSide(width: 4))),
          // validator: (value) =>
          // value != null && value.isEmpty ? 'Enter DoB': null,
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Phone Number Field
          TextFormField(
            controller: controller.phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone),
              labelText: STexts.phoneNo,
            ),
            validator: (value) {
              return SValidator.checkPhoneNumber(value);
            },
          ),
          const SizedBox(
            height: SSizes.spaceBtwInputFields,
          ),
          // Password Field
          TextFormField(
            controller: controller.password,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                icon: Icon(isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  // setState(() {
                  //   isPasswordVisible = !isPasswordVisible;
                  // });
                },
              ),
              labelText: STexts.password,
            ),
            validator: (value) => value != null && value.isEmpty
                ? 'Enter Password'
                : null,
          ),
          const SizedBox(
            height: SSizes.spaceBtwInputFields,
          ),

          /// Terms&Condiions Checkbox
          const STermsAndConditionCheckbox(),

          const SizedBox(
            height: SSizes.spaceBetweenItems,
          ),
          //Signup Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(STexts.createAccount),
              )),
          // TextButton(
          //   onPressed: () async {
          //     final form = _formkey.currentState!;
          //     final isValid = form.validate();
          //     if (isValid) {
          //       signUp();
          //     }
          //   },
          //   child: Container(
          //     width: 200,
          //     height: 55,
          //     decoration: BoxDecoration(
          //         color: Colors.pink,
          //         borderRadius: BorderRadius.circular(50)),
          //     child: Center(
          //         child: boolSignUpSuccessfull
          //             ? const CircularProgressIndicator(
          //                 color: Colors.white,
          //               )
          //             : const Text(
          //                 'Sign up',
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 30,
          //                   color: Colors.white,
          //                 ),
          //               )),
          //   ),
          // ),
        ],
      ),
      //Already have account switch between sign in and sign up
    );
  }
}

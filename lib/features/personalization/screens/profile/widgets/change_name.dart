import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/features/personalization/controllers/update_controller.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      /// Custom Appbar
      appBar: SAppBar(showBackArrow: true, title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall, ),),
      body: Padding(padding: const EdgeInsets.all(SSizes.defaultSpaces),
      child: Column(children: [
        /// Headings
        Text('Use real name for easy verfication. This name will appear on several pages.',
      style: Theme.of(context).textTheme.labelMedium,),
      const SizedBox(height: SSizes.spaceBetweenSections,),

      /// Text field and Button
      Form(key: controller.updateUserNameFormKey,
        child: Column(
        children: [
          TextFormField(
            controller: controller.firstName,
            validator: (value) => SValidator.validationEmptyText('First name', value),
            expands: false,
            decoration: const InputDecoration(labelText: STexts.firstName, prefixIcon: Icon(Iconsax.user)),
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields,),
          TextFormField(
            controller: controller.lastName,
            validator: (value) => SValidator.validationEmptyText('last name', value),
            expands: false,
            decoration: const InputDecoration(labelText: STexts.lastName, prefixIcon: Icon(Iconsax.user)),
          ),
        ],
      )),
      const SizedBox(height: SSizes.spaceBetweenSections,),

      /// Save Button
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text('Save'),),
      )

      ]),),
    );
  }
}
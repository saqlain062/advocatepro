import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/features/personalization/controllers/address_controller.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
        appBar: const SAppBar(
          showBackArrow: true,
          title: Text('Add new Address'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) => SValidator.validationEmptyText("Name", value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user), label: Text("Name"))),
                const SizedBox(
                  height: SSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.phoneNumer,
                  validator: (value) => SValidator.checkPhoneNumber(value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        label: Text("Phone Number"))),
                const SizedBox(
                  height: SSizes.spaceBtwInputFields,
                ),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.street,
                      validator: (value) => SValidator.validationEmptyText("Street", value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            label: Text("Street"))),
                  ),
                  const SizedBox(width: SSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.postalCode,
                     validator: (value) => SValidator.validationEmptyText("Postal Code",value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            label: Text("Postal Code"))),
                  ),
                ]),
                const SizedBox(
                  height: SSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) => SValidator.validationEmptyText("City", value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.building),
                              label: Text("City"))),
                    ),
                    const SizedBox(width: SSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) => SValidator.validationEmptyText("State", value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.activity),
                              label: Text("State"))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: SSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.country,
                  validator: (value) => SValidator.validationEmptyText("Country", value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.global),
                        label: Text("Country"))),
                const SizedBox(
                  height: SSizes.spaceBetweenSections,
                ),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
                  
                }
                , child: const Text('Save'),),)
              ],
            ),
          ),
        ));
  }
}

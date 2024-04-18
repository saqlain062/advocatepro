import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SAppBar(
          showBackArrow: true,
          title: Text('Add new Address'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user), label: Text("Name"))),
                const SizedBox(
                  height: SSizes.spaceBtwInputFields,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        label: Text("Phone Number"))),
                const SizedBox(
                  height: SSizes.spaceBtwInputFields,
                ),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            label: Text("Street"))),
                  ),
                  const SizedBox(width: SSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
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
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.building),
                              label: Text("City"))),
                    ),
                    const SizedBox(width: SSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
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

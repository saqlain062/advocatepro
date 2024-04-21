import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/features/personalization/controllers/address_controller.dart';
import 'package:advocatepro_f/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:advocatepro_f/features/personalization/screens/address/widgets/single_address.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(
          Iconsax.add,
          color: SColors.white,
        ),
      ),
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: Obx(
            () => FutureBuilder(
                // Use key to trigger refresh
                key: Key(controller.refreshData.value.toString()),
                future: controller.allUserAddresses(),
                builder: (context, snapshot) {
                  final widget = SCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);
                  if (widget != null) return widget;

                  final address = snapshot.data!;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: address.length,
                      itemBuilder: (_, index) => SSingleAddress(
                            address: address[index],
                            onTap: () =>
                                controller.selectAddress(address[index]),
                          ));
                }),
          ),
        ),
      ),
    );
  }
}

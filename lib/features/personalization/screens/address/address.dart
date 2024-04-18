import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:advocatepro_f/features/personalization/screens/address/widgets/single_address.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: SColors.white,),
      ),
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: const SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(
          children: [
            SSingleAddress(selectedAddress: false),
            SSingleAddress(selectedAddress: true),
          ],
        ),),
      ),
    );
  }
}

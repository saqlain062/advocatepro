import 'package:advocatepro_f/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:advocatepro_f/features/personalization/controllers/address_controller.dart';
import 'package:advocatepro_f/features/personalization/models/address_model.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SSingleAddress extends StatelessWidget {
  const SSingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;
  
  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = SHelperFunctions.isDarkMode(context);
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return InkWell(
        onTap: onTap,
        child: SRoundedContainer(
          padding: const EdgeInsets.all(SSizes.medium),
          width: double.infinity,
          showBorder: true,
          backgroundColor: selectedAddress
              ? SColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? SColors.darkerGrey
                  : SColors.grey,
          margin: const EdgeInsets.only(bottom: SSizes.spaceBetweenItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? dark
                          ? SColors.light
                          : SColors.dark
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: SSizes.small / 2,
                  ),
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: SSizes.small / 2,
                  ),
                  Text(address.toString(), softWrap: true,)
                ],
              )
            ],
          ),
        ),
      );
    
      }
    );
  }
}

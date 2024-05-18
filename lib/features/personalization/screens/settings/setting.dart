import 'package:advocatepro_f/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:advocatepro_f/common/widgets/list_tile/user_profile_tile.dart';
import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/screens/favourite/favourite.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_details/add_review.dart';
import 'package:advocatepro_f/features/lawyer/screen/homeScreen/add_detail/add_detail_screen.dart';
import 'package:advocatepro_f/features/personalization/screens/address/address.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/user_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            SPrimaryHeaderContainer(
              
                child: Column(
              children: [
                /// AppBar
                SAppBar(
                  title: Text(
                    "Account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: SColors.white),
                  ),
                ),

                /// -- User Profile Card
                const SUserProfileTile(),
                const SizedBox(
                  height: SSizes.spaceBetweenSections,
                )
              ],
            )),

            /// -- Body
            Padding(
                padding: const EdgeInsets.all(SSizes.defaultSpaces),
                child: Column(
                  children: [
                    /// -- Account Settings
                    const SSectionHeading(
                      title: 'Account Settings',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: SSizes.spaceBetweenItems,
                    ),

                    SSettingMenuTile(
                      icon: Iconsax.safe_home,
                      title: "My Addresses",
                      subTitle: "Show Address",
                      onTap: () => Get.to(() => const AddressScreen()),
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.favorite_chart,
                      title: "My Favourite",
                      subTitle: "Add and remove lawyer",
                      onTap: () => Get.to(() => const FavoriteScreen()),
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.notification,
                      title: "Notifications",
                      subTitle: "Set any kind of notification message",
                      onTap: () => Get.to(() => AddReviewInput()),
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.share,
                      title: "Invite friends",
                      subTitle: "Invite Your friends to join this app",
                      onTap: () {},
                    ),

                    /// -- App Settings
                    // const SizedBox(
                    //   height: SSizes.spaceBetweenSections,
                    // ),
                    // const SSectionHeading(
                    //   title: 'App Settings',
                    //   showActionButton: false,
                    // ),
                    // const SizedBox(
                    //   height: SSizes.spaceBetweenItems,
                    // ),
                    // SSettingMenuTile(
                    //   icon: Iconsax.document_upload,
                    //   title: "Load Data",
                    //   subTitle: "Upload Data to your Cloud Firebase",
                    //   onTap: () {},
                    // ),
                    // SSettingMenuTile(
                    //   icon: Iconsax.location,
                    //   title: "Geolocation",
                    //   subTitle: "Set recommendation based on location",
                    //   trailing: Switch(
                    //     value: true,
                    //     onChanged: (value) {},
                    //   ),
                    // ),
                    // SSettingMenuTile(
                    //   icon: Iconsax.security_user,
                    //   title: "Safe Mode",
                    //   subTitle: "Search result is safe",
                    //   trailing: Switch(
                    //     value: false,
                    //     onChanged: (value) {},
                    //   ),
                    // ),
                    // SSettingMenuTile(
                    //   icon: Iconsax.image,
                    //   title: "HD Image Quality",
                    //   subTitle: "Set image quality to be seen",
                    //   trailing: Switch(
                    //     value: false,
                    //     onChanged: (value) {},
                    //   ),
                    // ),

                    /// -- Logout Button
                    const SizedBox(height: SSizes.spaceBetweenSections,),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(onPressed: () => controller.logOurUserAccount(), child: const Text('Logout')),
                    ),
                    const SizedBox(height: SSizes.spaceBetweenSections * 2.5,),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

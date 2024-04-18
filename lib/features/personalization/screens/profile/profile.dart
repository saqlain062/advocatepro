import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/personalization/controllers/user_controller.dart';
import 'package:advocatepro_f/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:advocatepro_f/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const SAppBar(showBackArrow: true, title: Text('Profile'),),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(
          children: [
            /// Profile Picture
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx( () {
                    final networkImage = controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty ? networkImage : SImages.onBoardingImage2;

                    return controller.imageUplodaing.value ? const CircularProgressIndicator() : SCircularImage(image: image, width: 80,height: 80, isNetworkImage: networkImage.isNotEmpty,);} ),
                  TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                ],
              ),
            ),

            /// Details
            const SizedBox(height: SSizes.spaceBetweenItems/2,),
            const Divider(),
            const SizedBox(height: SSizes.spaceBetweenItems,),
            const SSectionHeading(title: 'Profile Information',showActionButton: false,),
            const SizedBox(height: SSizes.spaceBetweenItems,),

            SProfileMenu(onPressed: () => Get.to(() => const ChangeName()), title: 'Name', value: controller.user.value.fullName),
            SProfileMenu(onPressed: (){}, title: 'Username', value: controller.user.value.username),

            const SizedBox(height: SSizes.spaceBetweenItems,),
            const Divider(),
            const SizedBox(height: SSizes.spaceBetweenItems,),

            /// Heading Personal Info
            const SSectionHeading(title: 'Personal Information', showActionButton: false,),
            

            SProfileMenu(onPressed: (){}, title: 'User ID', value: controller.user.value.id,icon: Iconsax.copy,),
            SProfileMenu(onPressed: (){}, title: 'E-mail', value: controller.user.value.email),
            SProfileMenu(onPressed: (){}, title: 'Phone Number', value: controller.user.value.phoneNumber),
            SProfileMenu(onPressed: (){}, title: 'Gender', value: "Male"),
            SProfileMenu(onPressed: (){}, title: 'Date of Birth', value: "10 Oct 2001"),

            const Divider(),
            const SizedBox(height: SSizes.spaceBetweenItems,),

            Center(
              child: TextButton(onPressed: () => controller.deleteAccountWarningPopup(), child: const Text('Delete Account', style: TextStyle(color: Colors.red),)),
            )
          ],
        ),),
      ),
    );
  }
}
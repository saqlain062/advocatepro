import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/features/personalization/controllers/user_controller.dart';
import 'package:advocatepro_f/features/personalization/screens/profile/profile.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SUserProfileTile extends StatelessWidget {
  const SUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : SImages.noimage;

        return controller.imageUplodaing.value
            ? const CircularProgressIndicator()
            : SCircularImage(
                image: image,
                fit: BoxFit.fill,
                isNetworkImage: networkImage.isNotEmpty,
              );
      }),
      title: Text(controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: SColors.white)),
      subtitle: Text(controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: SColors.white)),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(
          Iconsax.edit,
          color: SColors.white,
        ),
      ),
    );
  }
}

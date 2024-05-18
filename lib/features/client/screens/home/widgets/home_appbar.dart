import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/features/client/screens/favourite/favourite.dart';
import 'package:advocatepro_f/features/client/screens/home/home.dart';
import 'package:advocatepro_f/features/personalization/controllers/user_controller.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SHomeAppBarClient extends StatelessWidget {
  const SHomeAppBarClient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return SAppBar(
      title: Obx(
        () { 
          if(controller.profileLoading.value){
            return const CircularProgressIndicator();
          }
          else {
           return Text(controller.user.value.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: SColors.white)); 
          }
          
  }),
      actions: [
        IconButton(onPressed: () => Get.to(() => const FavoriteScreen()), icon: const Icon(Icons.favorite, color: SColors.iconColorin,))
        // SNotificationCounterIcon(
        //   onPressed: () {},
        // )
      ],
    );
  }
}

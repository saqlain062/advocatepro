import 'package:advocatepro_f/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:advocatepro_f/features/client/home/widgets/home_appbar.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:flutter/material.dart';

class HomeScreenClient extends StatelessWidget {
  const HomeScreenClient({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          /// Header
          children: [
            SPrimaryHeaderContainer(
              child: Column(children: [
                /// -- Appbar
                SHomeAppBarClient(),

                /// -- Searchbar
                
                
                /// -- Categories
              ]),
            )
          ],
        ),
      ),
    );
  }
}



class SNotificationCounterIcon extends StatelessWidget {
  const SNotificationCounterIcon({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.notifications_none,
              color: SColors.iconColorin,
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                color: SColors.primary,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: SColors.iconColorin, fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:advocatepro_f/common/icons/S_circular_icon.dart';
import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card_vertical.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/features/client/screens/home/home.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
          title: Text(
            'Favorite',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            SCirularIcon(
              icon: Icons.add,
              onPressed: () => Get.to(const HomeScreenClient()),
            )
          ]),
          body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: Column(
            children: [
              SGridLayout(itemCount: 4, itemBuilder: (_,index) => SlawyerCardVertical(lawyer: LawyerModel.empty(),))
            ],
          ),
          )
          ),
    );
  }
}

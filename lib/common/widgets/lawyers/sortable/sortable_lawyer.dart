
import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card_vertical.dart';
import 'package:advocatepro_f/features/client/controllers/all_lawyer_controller.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SSortableLawyer extends StatelessWidget {
  const SSortableLawyer({
    super.key, required this.lawyer,
    
  });

  final List<LawyerModel> lawyer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllLawyersController());
    controller.assignLawyers(lawyer);
    return Column(children: [
      /// Dropdown
      DropdownButtonFormField(
          decoration:
              const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          
          items: ['Name','Newest', 'Popularity']
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
              value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortLawyers(value!);
          }),
          const SizedBox(height: SSizes.spaceBetweenSections,),
          ///Lawyer
          Obx(() => SGridLayout(itemCount: controller.lawyer.length, itemBuilder: (_, index) => SlawyerCardVertical(lawyer: controller.lawyer[index],)))
    ]);
  }
}

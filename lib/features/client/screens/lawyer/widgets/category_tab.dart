import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card_vertical.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_case.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/models/category_model.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SCategoryTab extends StatelessWidget {
  const SCategoryTab({
    super.key, required this.category,
  });
  
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpaces),
            child: Column(children: [
              /// -- Lawyer
              const SLawyerCase(),
              const SizedBox(
                height: SSizes.spaceBetweenItems,
              ),

              /// -- Similar
              SSectionHeading(
                title: 'Similar lawyer',
                onPressed: () {},
              ),
              const SizedBox(
                height: SSizes.spaceBetweenItems,
              ),
              SGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) => SlawyerCardVertical(lawyer: LawyerModel.empty(),)),
            const SizedBox(
                height: SSizes.spaceBetweenItems,
              ),
            ]),
            
          ),
        ]);
  }
}

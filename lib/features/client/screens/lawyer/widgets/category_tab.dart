import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card_vertical.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/controllers/category_controller.dart';
import 'package:advocatepro_f/features/client/models/category_model.dart';
import 'package:advocatepro_f/features/client/screens/all_lawyers/all_lawyers.dart';
import 'package:advocatepro_f/features/client/screens/lawyer/widgets/category_agencies.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SCategoryTab extends StatelessWidget {
  const SCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpaces),
            child: Column(children: [
              /// -- Agencies
              CategoryAgencies(
                category: category,
              ),
              const SizedBox(
                height: SSizes.spaceBetweenItems,
              ),

              /// -- Similar Lawyer
              FutureBuilder(
                  future: controller.getCategoryLawyer(categoryId: category.id),
                  builder: (context, snapshot) {
                    /// Helper Function: Handle Loader, No record, Or ERROR Message
                    final response =
                        SCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot);
                    if (response != null) return response;

                    // Record Found!
                    final lawyers = snapshot.data!;

                    return Column(
                      children: [
                        SSectionHeading(
                          title: 'You might like',
                          onPressed: () => Get.to(AllLawyers(title: category.name,
                          futureMethod: controller.getCategoryLawyer(categoryId: category.id,limit: -1),)),
                        ),
                        const SizedBox(
                          height: SSizes.spaceBetweenItems,
                        ),
                        SGridLayout(
                            itemCount: lawyers.length,
                            itemBuilder: (_, index) => SlawyerCardVertical(
                                  lawyer: lawyers[index],
                                )),
                        const SizedBox(
                          height: SSizes.spaceBetweenItems,
                        ),
                      ],
                    );
                  })
            ]),
          ),
        ]);
  }
}

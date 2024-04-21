import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/images/S_rounded_image.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card_horizontal.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/controllers/category_controller.dart';
import 'package:advocatepro_f/features/client/models/category_model.dart';
import 'package:advocatepro_f/features/client/screens/all_lawyers/all_lawyers.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;
  
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: SAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: Column(
            children: [
              /// Banner
              const SRoundImage(
                imageUrl: SImages.darkAppLogo,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(
                height: SSizes.spaceBetweenSections,
              ),

              /// Sub-Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    // Handle Loader, No Record, Or Error Message
                    final widget = SCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot);
                    if (widget != null) return widget;

                    // Record found
                    final subCategories = snapshot.data!;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories[index];
                          return FutureBuilder(
                              future: controller.getCategoryLawyer(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                // Handle Loader, No Record, Or Error Message
                                final widget =
                                    SCloudHelperFunctions.checkMultiRecordState(
                                        snapshot: snapshot);
                                if (widget != null) return widget;

                                // Record found
                                final lawyer = snapshot.data!;
                                return Column(
                                  children: [
                                    /// Heading
                                    SSectionHeading(
                                        title: subCategory.name,
                                        onPressed: () =>
                                            Get.to(() => AllLawyers(
                                                  title: subCategory.name,
                                                  futureMethod: controller
                                                      .getCategoryLawyer(
                                                          categoryId:
                                                              category.id,
                                                          limit: -1),
                                                ))),
                                    const SizedBox(
                                      height: SSizes.spaceBetweenItems / 2,
                                    ),

                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                          itemCount: lawyer.length,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                width: SSizes.spaceBetweenItems,
                                              ),
                                          itemBuilder: (context, index) =>
                                              SLawyerCardHorizontal(lawyer: lawyer[index])),
                                    ),
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

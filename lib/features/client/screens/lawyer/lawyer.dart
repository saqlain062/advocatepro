import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/appbar/tabbar.dart';
import 'package:advocatepro_f/common/widgets/custom_shapes/containers/serach_container.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/controllers/agency_controller.dart';
import 'package:advocatepro_f/features/client/controllers/category_controller.dart';
import 'package:advocatepro_f/features/client/screens/feature/agency.dart';
import 'package:advocatepro_f/features/client/screens/feature/agency_lawyer.dart';
import 'package:advocatepro_f/features/client/screens/lawyer/widgets/category_tab.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LawyerScreen extends StatelessWidget {
  const LawyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final agencyController = Get.put(AgencyController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: SAppBar(
          title: Text(
            'Lawyer',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: SHelperFunctions.isDarkMode(context)
                    ? SColors.black
                    : SColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(SSizes.defaultSpaces),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// -- Search bar
                      const SizedBox(
                        height: SSizes.spaceBetweenItems,
                      ),
                      const SSearchContainer(
                        text: 'Search',
                        showBackground: false,
                        showBorder: true,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: SSizes.spaceBetweenSections,
                      ),

                      /// -- Featured Agencies
                      SSectionHeading(
                        title: 'Featured Agencies',
                        onPressed: () =>
                            Get.to(() => const CourtLawyersScreen()),
                      ),
                      const SizedBox(
                        height: SSizes.spaceBetweenItems / 1.5,
                      ),

                      /// -- Agencies Grid
                      Obx(
                        () {
                          if(agencyController.isLoading.value) return const CircularProgressIndicator();
                          if(agencyController.featuredAgencies.isEmpty){
                            return Center(
                              child: Text('No data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),
                            );
                          }
                          return SGridLayout(
                            itemCount: agencyController.featuredAgencies.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final agency = agencyController.featuredAgencies[index];
                              return SlawyerCard(
                                showBorder: true, agency: agency, onTap: () => Get.to(() => CourtLawyers(agency: agency)),
                              );
                            });
                        } 
                      )
                    ],
                  ),
                ),

                /// Tabs
                bottom: STabBar(
                    tabs: categories
                        .map((category) => Tab(
                              child: Text(category.name),
                            ))
                        .toList(),
                        ),
              )
            ];
          },
          body: TabBarView(
              children: categories
                  .map((category) => SCategoryTab(category: category))
                  .toList()),
        ),
      ),
    );
  }
}

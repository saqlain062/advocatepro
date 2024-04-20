import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/controllers/agency_controller.dart';
import 'package:advocatepro_f/features/client/screens/feature/agency_lawyer.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourtLawyersScreen extends StatelessWidget {
  const CourtLawyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final agencyController = AgencyController.instance;
    return Scaffold(
      appBar: const SAppBar(
        title: Text('Agency'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: Column(
            children: [
              /// Heading
              const SSectionHeading(title: 'Agencies'),
              const SizedBox(
                height: SSizes.spaceBetweenItems,
              ),

              /// -- Agencies Grid
              Obx(() {
                if (agencyController.isLoading.value) return const CircularProgressIndicator();
                if (agencyController.allAgencies.isEmpty) {
                  return Center(
                    child: Text(
                      'No data Found!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  );
                }
                return SGridLayout(
                    itemCount: agencyController.allAgencies.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final agency = agencyController.allAgencies[index];
                      return SlawyerCard(
                        showBorder: true,
                        agency: agency,
                        onTap: () => Get.to(() => CourtLawyers(agency: agency,)),
                      );
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}

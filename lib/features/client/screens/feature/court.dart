import 'package:advocatepro_f/common/layout/grid_layout.dart';
import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/screens/feature/court_lawyer.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourtLawyersScreen extends StatelessWidget {
  const CourtLawyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(
        title: Text('Court'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: Column(
            children: [
              /// Heading
              const SSectionHeading(title: 'Courts'),
              const SizedBox(
                height: SSizes.spaceBetweenItems,
              ),

              /// -- Courts
              SGridLayout(
                  itemCount: 10,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) => SlawyerCard(
                        showBorder: true, 
                        onTap: () => Get.to(() => const CourtLawyers()),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}

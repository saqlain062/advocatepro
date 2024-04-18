import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/images/S_rounded_image.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card_horizontal.dart';
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(
        title: Text('Familys'), showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: 
        const EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(
          children: [
            /// Banner
            const SRoundImage(imageUrl: SImages.darkAppLogo, width: double.infinity, applyImageRadius: true,),
            const SizedBox(height: SSizes.spaceBetweenSections,),

            /// Sub-Categories
            Column(
              children: [
                /// Heading
                SSectionHeading(title: 'Court or Place', onPressed: () {
                  
                },),
                const SizedBox(height: SSizes.spaceBetweenItems / 2,),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(width: SSizes.spaceBetweenItems,),
                    itemBuilder:(context, index) => const SLawyerCardHorizontal()),
                ),
              ],
            )
          ],
        ),),
      ),
    );
  }
}

import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_details/widgets/lawyer_detail_image_slider.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_details/widgets/lawyer_meta_data.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_details/widgets/rating_share_widget.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_reviews/lawyer_reviews.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LawyerDetailScreen extends StatelessWidget {
  const LawyerDetailScreen({super.key, required this.lawyer});

  final LawyerModel lawyer;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Lawyer Image Slider
            SLawyerImageSlider(lawyer: lawyer,),

            /// Lawyer Details
            Padding(padding: const EdgeInsets.only(right: SSizes.defaultSpaces , left: SSizes.defaultSpaces, bottom: SSizes.defaultSpaces),
            child: Column(
              children: [
                /// - Rating & Share Button
                const SRatingAndShare(),

                /// - Title and Description
                SLawyerMetaData(lawyer: lawyer,),

                /// - Button
                const Divider(),
                const SizedBox(height: SSizes.spaceBetweenItems,),
                SizedBox(width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: const Text('Message')),),
                const SizedBox(height: SSizes.spaceBetweenItems,),

                /// - Reviews
                
                SSectionHeading(title: 'Reviews(199)', onPressed: () => Get.to(() => const LawyerReviews()),),
                const SizedBox(height: SSizes.spaceBetweenSections,)

              ],
            ),)
          ],
        ),
      ),
    );
  }
}

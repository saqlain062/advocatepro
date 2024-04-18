import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/lawyers/ratings/rating_indicator.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_reviews/widgets/rating_progress_indicator.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_reviews/widgets/user_review_card.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LawyerReviews extends StatelessWidget {
  const LawyerReviews ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar
      appBar: const SAppBar(title: Text('Reviews & Ratings'), showBackArrow: true,),
      /// Body
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(
          children: [
            const Text("Ratings and reviews are verified and are from people who use the verfied account"),
            const SizedBox(height: SSizes.spaceBetweenItems,),

            /// Overall lawyer Ratings
            const SOverallLawyerRating(),
            const SRatingBarIndicator(rating: 3.5,),
            Text('12,611', style: Theme.of(context).textTheme.bodySmall,),
            const SizedBox(height: SSizes.spaceBetweenSections,),

            /// User Reviews List
            const UserReviewCard(),
             const UserReviewCard(),
          ],
        ),),
      ),
    );
  }
}


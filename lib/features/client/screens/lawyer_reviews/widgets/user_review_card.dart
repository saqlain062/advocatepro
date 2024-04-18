import 'package:advocatepro_f/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:advocatepro_f/common/widgets/lawyers/ratings/rating_indicator.dart';
import 'package:advocatepro_f/common/widgets/texts/readmore.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(SImages.darkAppLogo),
                ),
                const SizedBox(
                  width: SSizes.spaceBetweenItems,
                ),
                Text(
                  'Saqlain',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          height: SSizes.spaceBetweenItems,
        ),

        /// Review
        Row(
          children: [
            const SRatingBarIndicator(rating: 4),
            const SizedBox(
              width: SSizes.spaceBetweenItems,
            ),
            Text(
              '01 Nov, 2023',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: SSizes.spaceBetweenItems,
        ),
        const SReadMore(
            text:
                'The user interface of the app is quite intuitive. i was able to navigate and make puchase somele .... dfakdfj dk  '),
        const SizedBox(
          height: SSizes.spaceBetweenItems,
        ),

        /// Lawyer Review
        SRoundedContainer(
          backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
          child: Padding(padding: const EdgeInsets.all(SSizes.medium),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lawyer', style: Theme.of(context).textTheme.titleMedium,),
                  Text('02 nov, 2023', style: Theme.of(context).textTheme.bodyMedium,)
                ],
              ),
              const SizedBox(height: SSizes.spaceBetweenItems,),
              const SReadMore(
            text:
                'The user interface of the app is quite intuitive. i was able to navigate and make puchase somele .... dfakdfj dk  '),
        
            ],
          ),),
        ),
        const SizedBox(height: SSizes.spaceBetweenItems,)
      ],
    );
  }
}

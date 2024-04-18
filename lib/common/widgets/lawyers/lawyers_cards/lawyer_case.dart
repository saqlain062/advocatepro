
import 'package:advocatepro_f/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SLawyerCase extends StatelessWidget {
  const SLawyerCase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SRoundedContainer(
      showBorder: true,
      borderColor: SColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.only(bottom: SSizes.spaceBetweenItems),
      child: Column(
        children: [
          /// Lawyer with reviews
          SlawyerCard(showBorder: false,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SSizes.medium),
            child: Row(
              children: [
                Icon(Icons.cases_outlined),
                SizedBox(
                  width: SSizes.spaceBetweenItems / 2,
                ),
                Text('10'),
                Spacer(),
                Icon(Icons.favorite_border),
                SizedBox(
                  width: SSizes.spaceBetweenItems / 2,
                ),
                Text('10'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

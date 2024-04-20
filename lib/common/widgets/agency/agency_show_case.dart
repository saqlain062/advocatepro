import 'package:advocatepro_f/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card.dart';
import 'package:advocatepro_f/features/client/models/agency_model.dart';
import 'package:advocatepro_f/features/client/screens/feature/agency_lawyer.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SAgencyShowCase extends StatelessWidget {
  const SAgencyShowCase({super.key, required this.images, required this.agency});

  final AgencyModel agency;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => CourtLawyers(agency: agency))
      ,child: SRoundedContainer(
        showBorder: true,
        borderColor: SColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(SSizes.medium),
        margin: const EdgeInsets.only(bottom: SSizes.spaceBetweenItems),
        child: Column(
          children: [
            /// Agency with Lawyer Count
            SlawyerCard(showBorder: false, agency: agency),
            const SizedBox(height: SSizes.spaceBetweenItems,),

            /// Agency Top 3 Lawyer Images
            Row(children: images.map((image) => agencyTopLawyerImageWidget(image, context)).toList())
          ],
        ),
      ),
    );
  }

  Widget agencyTopLawyerImageWidget(String image, context){
    return Expanded(child: SRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(SSizes.medium),
      margin: const EdgeInsets.only(right: SSizes.smallmedium),
      backgroundColor: SHelperFunctions.isDarkMode(context) ? SColors.darkerGrey : SColors.light,
      child: Image(fit: BoxFit.contain, image: AssetImage(image),),));
  }
}
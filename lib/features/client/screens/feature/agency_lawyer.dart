import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card.dart';
import 'package:advocatepro_f/common/widgets/lawyers/sortable/sortable_lawyer.dart';
import 'package:advocatepro_f/features/client/controllers/agency_controller.dart';
import 'package:advocatepro_f/features/client/models/agency_model.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CourtLawyers extends StatelessWidget {
  const CourtLawyers({super.key, required this.agency});

  final AgencyModel agency;
  @override
  Widget build(BuildContext context) {
    final controller = AgencyController.instance;
    return Scaffold(
      appBar: SAppBar(title: Text(agency.name),),
      body: SingleChildScrollView(
        child: Padding(padding: 
        const EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(
          children: [
            /// Courts Lawyers 
            SlawyerCard(showBorder: true, agency: agency,),
            const SizedBox(height: SSizes.spaceBetweenSections,),

            FutureBuilder(
              future: controller.getAgencyLawyers(agencyId: agency.id),
              builder: (context, snapshot) {

                /// Handle Loader, No Record, Or Error Message
                final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if(widget != null) return widget;
                
                /// Record Found!
                final  agencyLawyer = snapshot.data!;
                return SSortableLawyer(lawyer: agencyLawyer,);
              }
            ),
          ],
        ),),
      ),
    );
  }
}
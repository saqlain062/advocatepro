import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/lawyers/lawyers_cards/lawyer_card.dart';
import 'package:advocatepro_f/common/widgets/lawyers/sortable/sortable_lawyer.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CourtLawyers extends StatelessWidget {
  const CourtLawyers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SAppBar(title: Text('Supreme Court'),),
      body: SingleChildScrollView(
        child: Padding(padding: 
        EdgeInsets.all(SSizes.defaultSpaces),
        child: Column(
          children: [
            /// Courts Lawyers 
            SlawyerCard(showBorder: true),
            SizedBox(height: SSizes.spaceBetweenSections,),

            SSortableLawyer(lawyer: [],),
          ],
        ),),
      ),
    );
  }
}
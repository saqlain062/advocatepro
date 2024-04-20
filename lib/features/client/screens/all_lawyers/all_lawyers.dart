import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/common/widgets/lawyers/sortable/sortable_lawyer.dart';
import 'package:advocatepro_f/features/client/controllers/all_lawyer_controller.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/helpers/cloud_helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/lawyer_model.dart';

class AllLawyers extends StatelessWidget {
  const AllLawyers({super.key,
    required this.title,
    this.query,
    this.futureMethod,});

  
  final String title;
  final Query? query;
  final Future<List<LawyerModel>>? futureMethod;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllLawyersController());
    return Scaffold(
      appBar: SAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchLawyersByQuery(query),
            builder: (context, snapshot) {
              // Check the state of the FutureBuilder snapshot
              final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);

              // Return appropriate widget based on snapshot state
              if(widget != null ) return widget;

              // Lawyer found
              final lawyer = snapshot.data!;
              return SSortableLawyer(lawyer: lawyer);
            }
          ),
        ),
      ),
    );
  }
}

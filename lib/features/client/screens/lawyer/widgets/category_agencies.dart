import 'package:advocatepro_f/common/widgets/agency/agency_show_case.dart';
import 'package:advocatepro_f/features/client/controllers/agency_controller.dart';
import 'package:advocatepro_f/features/client/models/category_model.dart';
import 'package:advocatepro_f/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryAgencies extends StatelessWidget {
  const CategoryAgencies({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = AgencyController.instance;
    return FutureBuilder(
        future: controller.getAgencyForCategory(category.id),
        builder: (context, snapshot) {
          final widget =
              SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
          if (widget != null) return widget;

          /// Record Found!
          final agencies = snapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: agencies.length,
              itemBuilder: (_, index) {
                final agency = agencies[index];
                return FutureBuilder(
                    future: controller.getAgencyLawyers(
                        agencyId: agency.id, limit: 3),
                    builder: (context, snapshot) {
                      final widget =
                          SCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot);
                      if (widget != null) return widget;

                      /// Record Found!
                      final lawyers = snapshot.data!;
                      return SAgencyShowCase(
                        agency: agency,
                        images: lawyers.map((e) => e.thumbnail).toList()
                      );
                    });
              });
        });
  }
}

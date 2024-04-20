import 'package:advocatepro_f/features/client/models/agency_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AgencyRepository extends GetxController {
  static AgencyRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Gel all categories
  Future<List<AgencyModel>> getAllAgencies() async{
    try {
      final snapshot = await _db.collection('Agencies').get();
      final list = snapshot.docs.map((document) => AgencyModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'list Something went wrong. Please try again';
    }
  }
  
  /// Get Agencies For Category
  Future<List<AgencyModel>> getAgencyForCategory(String categoryId) async{
    try {
      // Query to get alll documents where cateforyID matches the provided categoryId
      QuerySnapshot agencyCategoryQuery = await _db.collection("AgencyCategory").where('categoryId', isEqualTo: categoryId).get();

      // Extract agencyIds from the documents
      List<String> agencyIds = agencyCategoryQuery.docs.map((e) => e['agencyId'] as String).toList();

      // Query to get all documents where the agencyId is in the list of angencyids, FieldPath.documentid to query documents in Collection
      final agenciesQuery = await _db.collection('Agencies').where(FieldPath.documentId, whereIn: agencyIds).limit(2).get();

      // Extract agency names or other relevant data from the dcouments
      List<AgencyModel> agencies = agenciesQuery.docs.map((e) => AgencyModel.fromSnapshot(e)).toList();

      return agencies;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'list Something went wrong. Please try again';
    }
  }
  
}
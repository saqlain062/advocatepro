import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class LawyerRepository extends GetxController {
  static LawyerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Get limited featured Lawyers
  Future<List<LawyerModel>> getFeaturedLawyers() async {
    try {
      final snapshot = await _db
          .collection('Lawyers')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => LawyerModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'list Something went wrong. Please try again';
    }
  }

  /// Get All featured lawyers
  Future<List<LawyerModel>> getAllFeaturedLawyers() async {
    try {
      final snapshot = await _db
          .collection('Lawyers')
          .where('isFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => LawyerModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'list Something went wrong. Please try again';
    }
  }

  /// Get lawyer based on spec
  Future<List<LawyerModel>> getLawyerByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<LawyerModel> lawyerList = querySnapshot.docs
          .map((doc) => LawyerModel.fromQuerySnapshot(doc))
          .toList();
      return lawyerList;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

   /// Get lawyer based on spec
  Future<List<LawyerModel>> getFavouriteLawyers(List<String> lawyerIds) async {
    try {
      final sanpshot = await _db.collection("Lawyers").where(FieldPath.documentId, whereIn: lawyerIds).get();
      return sanpshot.docs.map((e) => LawyerModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<LawyerModel>> getLawyersForAgency(
      {required String agencyId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Lawyers')
              .where("Agency.Id", isEqualTo: agencyId)
              .get()
          : await _db
              .collection('Lawyers')
              .where("Agency.Id", isEqualTo: agencyId)
              .limit(limit)
              .get();
      final lawyers = querySnapshot.docs.map((e) => LawyerModel.fromSnapshot(e)).toList();
      return lawyers;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

    Future<List<LawyerModel>> getLawyersForCategroy(
      {required String categoryId, int limit = -1}) async {
    try {
     // Query to get all documents where lawyerIs matches the provided categoryId & Fetch limited or unlimited based on limit
     QuerySnapshot lawyerCategoryQuery = limit == -1 
     ? await _db.collection("LawyerCategory").where('categoryId', isEqualTo: categoryId).get()
     : await _db.collection("LawyerCategory").where('categoryId', isEqualTo: categoryId).limit(limit).get();

     // Extract lawyerIds from the documents
     List<String> lawyerIds = lawyerCategoryQuery.docs.map((e) => e['lawyerId'] as String).toList();

     // Query to get all documents where the agencyId is in the list of agencyids, FieldPath.documentId to query documents in Collection
     final lawyersQuery = await _db.collection("Lawyers").where(FieldPath.documentId, whereIn: lawyerIds).get();

     // Extract agency names or other relevant data from the documensts
     List<LawyerModel> lawyer = lawyersQuery.docs.map((e) => LawyerModel.fromSnapshot(e)).toList();

     return lawyer;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}

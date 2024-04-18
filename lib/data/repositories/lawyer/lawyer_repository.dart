import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class LawyerRepository extends GetxController {
  static LawyerRepository get  instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Get limited featured products
  Future<List<LawyerModel>> getFeaturedLawyers() async {
    try {
      final snapshot = await _db.collection('Lawyers').where('isFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => LawyerModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'list Something went wrong. Please try again';
    }
  }

  /// Get All featured products
  Future<List<LawyerModel>> getAllFeaturedLawyers() async {
    try {
      final snapshot = await _db.collection('Lawyers').where('isFeatured', isEqualTo: true).get();
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
      final List<LawyerModel> lawyerList = querySnapshot.docs.map((doc) => LawyerModel.fromQuerySnapshot(doc)).toList();
      return lawyerList;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'list Something went wrong. Please try again';
    }
  }
}
import 'dart:io';

import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/features/personalization/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore
  Future<void> saveUserRecord(String collection, user) async {
    try {
      await _db.collection(collection).doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw '';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }

  /// Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw '';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }

  /// Function to update user data to Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw '';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }

  /// Update any field in specific Users Collection
  Future<void> updateSingleField(String collection,Map<String, dynamic> json) async {
    try {
      await _db
          .collection(collection)
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw '';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }

  /// Function to remove user data from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw '';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }

  /// Uplode Any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw '';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }
}

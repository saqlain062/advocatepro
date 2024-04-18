import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;

  BrandModel(
      {required this.id,
      required this.name,
      required this.image,
      this.isFeatured});

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  /// Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {'Id': id, 'Name': name, 'Image': image, 'IsFeatured': isFeatured};
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        image: data['Images'] ?? '',
        isFeatured: data['IsFeatured'] ?? false);
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BrandModel(
        id: document.id, name: data['Name'], image: data['Images']);
  }
}

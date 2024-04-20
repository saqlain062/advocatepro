import 'package:cloud_firestore/cloud_firestore.dart';

class AgencyModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? lawyersCounts;

  AgencyModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.lawyersCounts,
  });

  /// Empty Helper Function
  static AgencyModel empty() => AgencyModel(id: '', name: '', image: '');

  /// Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'Lawyers': lawyersCounts,
      'IsFeatured': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory AgencyModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return AgencyModel.empty();
    return AgencyModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        lawyersCounts: int.parse((data['Lawyers'] ?? 0).toString()));
  }

factory AgencyModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      // Map JSON Record to the Model
      return AgencyModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        lawyersCounts: data['Lawyers'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return AgencyModel.empty();
    }
  }
}

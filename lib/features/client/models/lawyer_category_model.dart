import 'package:cloud_firestore/cloud_firestore.dart';

class LawyerCategoryModel {
  final String lawyerId;
  final String categoryId;

  LawyerCategoryModel({
    required this.lawyerId,
    required this.categoryId,
  });

  Map<String, dynamic> toJosn() {
    return {
      'lawyerId': lawyerId,
      'categoryId': categoryId,
    };
  }

  factory LawyerCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return LawyerCategoryModel(
        lawyerId: data['lawyerId'] as String, categoryId: data['categoryId'] as String);
  }
}

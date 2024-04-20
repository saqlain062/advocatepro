import 'package:cloud_firestore/cloud_firestore.dart';

class AgencyCategoryModel {
  final String agencyId;
  final String categoryId;

  AgencyCategoryModel({
    required this.agencyId,
    required this.categoryId,
  });

  Map<String, dynamic> toJosn() {
    return {
      'agencyId': agencyId,
      'categoryId': categoryId,
    };
  }

  factory AgencyCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AgencyCategoryModel(
        agencyId: data['agencyId'] as String, categoryId: data['categoryId'] as String);
  }
}

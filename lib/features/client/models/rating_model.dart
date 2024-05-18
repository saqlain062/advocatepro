import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  int ratingValue;
  double percentage;

  RatingModel({
    required this.ratingValue,
    required this.percentage,
  });

  /// Create Empty func for clean code
  static RatingModel empty() => RatingModel(
        ratingValue: 0,
        percentage: 0,
      );

  /// Json Format
  Map<String, dynamic> toJson() {
    return {
      'RatingValue': ratingValue,
      'Percentage': percentage,
    };
  }

  /// Map Json oriented document snapshot form Firestore to Model
  factory RatingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return RatingModel.empty();
    final data = document.data()!;
    return RatingModel(
      ratingValue: data['RatingValue'],
      percentage: data['Percentage'],
    );
  }

  /// Map Json oriented query document snapshot form Firestore to Model
  factory RatingModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return RatingModel(
      ratingValue: data['RatingValue'],
      percentage: data['Percentage'],
    );
  }
}

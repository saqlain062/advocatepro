import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String id;
  String userName;
  double rating;
  String reviewText;
  String? images;
  DateTime date;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.rating,
    required this.reviewText,
    required this.date,
    this.images,
  });

  /// Create Empty func for clean code
  static ReviewModel empty() => ReviewModel(
        id: '',
        userName: '',
        rating: 0,
        reviewText: '',
        images: '',
        date: DateTime.now(),
      );

  /// Json Format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'UserName': userName,
      'Rating': rating,
      'ReviewText': reviewText,
      'Date': date,
      'Image':images
    };
  }

  /// Map Json oriented document snapshot form Firestore to Model
  factory ReviewModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ReviewModel.empty();
    final data = document.data()!;
    return ReviewModel(
      id: document.id,
      userName: data['UserName'],
      rating: data['Rating'],
      reviewText: data['ReviewText'],
      images: data['Image'],
      date: data['Date'].toDate(), // Assuming 'Date' is stored as a Firestore Timestamp
    );
  }

  /// Map Json oriented query document snapshot form Firestore to Model
  factory ReviewModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ReviewModel(
      id: document.id,
      userName: data['UserName'],
      rating: data['Rating'],
      reviewText: data['ReviewText'],
      images: data['Image'],
      date: data['Date'].toDate(), // Assuming 'Date' is stored as a Firestore Timestamp
    );
  }
}

import 'package:advocatepro_f/features/client/models/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LawyerModel {
  String id;
  String title;
  String spec;
  DateTime? date;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;

  LawyerModel({
    required this.id,
    required this.title,
    required this.spec,
    required this.thumbnail,
    this.brand,
    this.categoryId,
    this.date,
    this.description,
    this.images,
    this.isFeatured,
  });

  /// Create Empty func for clean code
  static LawyerModel empty() => LawyerModel(id: '', title: '', thumbnail: '', spec: '');

  /// Json Format
  toJson() {
    return {
      'Title': title,
      'specialization' : spec,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand!.toJson(),
      'Description': description,
    };
  }

  /// Map Json oriented document snapshot form Firbase to Model
  factory LawyerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() == null ) return LawyerModel.empty();
    final data = document.data()!;
    return LawyerModel(
      id: document.id,
      title: data['Title'],
      spec: data['specialization'],
      isFeatured: data['isFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
    );
  }

  /// Map Json oriented query document snapshot form Firbase to Model
  factory LawyerModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return LawyerModel(
      id: document.id,
      title: data['Title'],
      spec: data['specialization'],
      isFeatured: data['isFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
    );
  }
}

import 'package:advocatepro_f/features/client/models/lawyer_model.dart';

class ChatModel {
  late LawyerModel lawyer;
  late String about;
  String? createdAt;
  String? isOnline;
  bool? lastActive;
  String? pushToken;
  late String email;

  ChatModel({
    required this.about,
    required this.email,
    required this.lawyer,
    this.createdAt,
    this.isOnline,
    this.lastActive,
    this.pushToken,
  });

  static ChatModel empty() =>
      ChatModel(about: "about", email: "email", lawyer: LawyerModel.empty());

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = lawyer.id;
    data['Title'] = lawyer.title;
    data['Thumbnail'] = lawyer.thumbnail;
    data['About'] = about;
    data['Email'] = email;
    data['CreatedAt'] = createdAt;
    data['IsOnline'] = isOnline;
    data['LastActive'] = lastActive;
    data['PushToken'] = pushToken;
    return data;
  }

  ChatModel.fromSnapshot(Map<String, dynamic> json) {
    lawyer = LawyerModel(
      id: json['Id'] ?? '',
      title: json['Title'] ?? '',
      thumbnail: json['Thumbnail'] ?? '',
    );
    about = json['About'] ?? '';
    email = json['Email'] ?? '';
    createdAt = json['CreatedAt'] ?? '';
    isOnline = json['IsOnline'] ?? '';
    lastActive = json['LastActive'] ?? false;
    pushToken = json['PushToken'] ?? '';
  }
}

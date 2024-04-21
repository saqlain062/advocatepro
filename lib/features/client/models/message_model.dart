import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  MessageModel(
      {required this.message,
      required this.receiverId,
      required this.senderEmail,
      required this.senderId,
      required this.timestamp});

  // convert ot a map
  Map<String, dynamic> toMap() {
    return {
      'SenderId': senderId,
      'SenderEmail': senderEmail,
      'ReceiverId': receiverId,
      'Message': message,
      "TimeStamp": timestamp,
    };
  }

  factory MessageModel.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return MessageModel(
        message: data["Message"],
        receiverId: data["ReceiverId"],
        senderEmail: data["SenderEmail"],
        senderId: data["SenderId"],
        timestamp: data["TimeStamp"]);
  }
}

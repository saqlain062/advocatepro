import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String read;
  final String receiverId;
  final String message;
  Type? type;
  final String sent;
  final Timestamp timestamp;

  // Constructor
  Message({
    required this.senderId,
    required this.read,
    required this.receiverId,
    required this.message,
    required this.sent,
    this.type,
    required this.timestamp
  });

  // Convert a Message instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'read': read,
      'receiverId': receiverId,
      'message': message,
      'sent': sent,
      'type' : type?.name,
      'timestamp' : timestamp 
    };
  }

  // Create a Message instance from a JSON map
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'] as String,
      read: json['read'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      sent: json['sent'] as String,
      timestamp: json['timestamp'] as Timestamp,
      type: json['type'].toString() == Type.image.name ? Type.image : Type.text,
    );
  }


}

enum Type { text, image}
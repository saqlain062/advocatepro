import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/features/client/models/Message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatService extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final authenticationRepository = Get.put(AuthenticationRepository());

  /// Send Message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = authenticationRepository.authUser!.uid;
    final String currentUserEmail =
        authenticationRepository.authUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    MessageModel newMessage = MessageModel(
        message: message,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        senderId: currentUserId,
        timestamp: timestamp);

    // construct chat room id from current user id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sor the ids (this ensures the chat room id is always the same for any pair of )
    String chatRoomId = ids.join("_");

    // add a new message to database
    await _db
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Messages")
        .add(newMessage.toMap());
  }

  // Get Message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // construct chat room id from user ids
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _db
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Messages")
        .orderBy("TimeStamp", descending: false)
        .snapshots();
  }
}

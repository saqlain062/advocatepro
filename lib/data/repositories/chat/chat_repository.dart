import 'package:advocatepro_f/features/client/models/chat/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../object/object.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, message) async {
    // get current user info
    final String currentUserID = SObject.auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    // create a new Message
    Message newMessage = Message(
      senderId: currentUserID,
      receiverId: receiverId,
      message: message,
      read: 'akdfjkdsfk',
      sent: '',
      timestamp: timestamp,
      // type: Type.text
    );
    // chat room id
    List<String> ids = [currentUserID, receiverId];
    ids.sort(); // sort the ids
    String chatRoomId = ids.join('_');

    print('-----$newMessage-----------------$chatRoomId');

    // add new message to database
    await _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toJson());
    final Map<String,dynamic> id = {'receiverId' : receiverId};
    await _firestore.collection('chats').doc(chatRoomId).set(id);
  }

  // get messages
  Stream<QuerySnapshot> getMessage(String userId, otheruserId) {
    // construct a chatroom Id
    List<String> ids = [userId, otheruserId];
    ids.sort(); // sort the ids
    String chatRoomId = ids.join('_');
    return _firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }


  // get chat
  Stream<QuerySnapshot> getChats() {

    return _firestore
        .collection("chats")
        .doc()
        .collection("messages")
        .snapshots();
  }
}

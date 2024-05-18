import 'package:advocatepro_f/data/repositories/user/user_repository.dart';
import 'package:advocatepro_f/features/client/models/chat/chat_model.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../object/object.dart';

class InboxRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setSdata(LawyerModel lawyer) async {
    // get current user info
    final User currentUserID = SObject.auth.currentUser!;
    print('--------------------------------------------');
    // create a new Message
    ChatModel newChat = ChatModel(
        createdAt: '',
        isOnline: '',
        lastActive: true,
        pushToken: '',
        about: lawyer.spec ?? '',
        email: '',
        lawyer: LawyerModel(
            id: lawyer.id, title: lawyer.title, thumbnail: lawyer.thumbnail));

    // add new chat to database
    await _firestore
        .collection('inbox')
        .doc(currentUserID.uid)
        .collection('chatroom')
        .add(newChat.toJson());
  }

  Future<void> setRdata(LawyerModel lawyer,lawyerid) async {
    // get current user info
    final repo = UserRepository();
    final user = await repo.fetchUserDetails();
    
    print('===============================================');
    ChatModel chat = ChatModel(
        createdAt: '',
        isOnline: '',
        lastActive: true,
        pushToken: '',
        about: '',
        email: user.email,
        lawyer: LawyerModel(
            id: user.id,
            title: user.fullName,
            thumbnail: user.profilePicture));

    await _firestore
        .collection('inbox')
        .doc(lawyerid)
        .collection('chatroom')
        .add(chat.toJson());
  }

  // get messages
  Stream<QuerySnapshot> getChat() {
    final String currentUserID = SObject.auth.currentUser!.uid;
    return _firestore
        .collection("inbox")
        .doc(currentUserID)
        .collection("chatroom")
        // .orderBy("Timestamp", descending: false)
        .snapshots();
  }

  Future<bool> alreadyChat(String receiverId) async {
    final String currentUserID = SObject.auth.currentUser!.uid;
    final doc = await _firestore
        .collection("inbox")
        .doc(currentUserID)
        .collection('chatroom')
        .where('Id', isEqualTo: receiverId)
        .get();
    return doc.docs.isNotEmpty;
  }
}

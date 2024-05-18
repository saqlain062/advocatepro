
import 'package:advocatepro_f/data/object/object.dart';
import 'package:advocatepro_f/features/client/models/review_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LawyerRepository extends GetxController {
  static LawyerRepository get instance => Get.find();

  final _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, message) async {
    // get current user info
    final String currentUserID = SObject.auth.currentUser!.uid;
    // create a new Message
    ReviewModel newReview = ReviewModel(id: 'id', userName: 'userName', rating: 0, reviewText: 'reviewText', date: DateTime.now() 
      // type: Type.text
    );
    // chat room id
    List<String> ids = [currentUserID, receiverId];
    ids.sort(); // sort the ids
    String chatRoomId = ids.join('_');

    // add new message to database
    await _firestore
        .collection('Review')
        .doc(chatRoomId)
        .collection("messages")
        .add(newReview.toJson());
    final Map<String,dynamic> id = {'receiverId' : receiverId};
    await _firestore.collection('chats').doc(chatRoomId).set(id);
  }

  // // get messages
  // Stream<QuerySnapshot> getMessage(String userId, otheruserId) {
  //   // construct a chatroom Id
  //   List<String> ids = [userId, otheruserId];
  //   ids.sort(); // sort the ids
  //   String chatRoomId = ids.join('_');
  //   return _firestore
  //       .collection("chats")
  //       .doc(chatRoomId)
  //       .collection("messages")
  //       // .orderBy("Timestamp", descending: false)
  //       .snapshots();
  // }


}

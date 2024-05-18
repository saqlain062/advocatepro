import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/chat/chat_repository.dart';
import '../../models/chat/chat_model.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  final ChatRepository chatRepository = ChatRepository();
  final message = TextEditingController();
  var chatList = RxList<ChatModel>([]);

}


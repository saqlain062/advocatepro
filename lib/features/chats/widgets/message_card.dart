import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../client/models/chat/message_model.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    bool isCurrentUser =
        message.senderId == AuthenticationRepository.instance.authUser!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: MessageBox(message: message.message, isCurrentUser: isCurrentUser,time : message.timestamp),
    );
  }
}

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
    required this.time,
    required this.isCurrentUser,
  });

  final String message;
  final Timestamp time;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SSizes.smallmedium),
      margin: const EdgeInsets.symmetric(
          horizontal: SSizes.large, vertical: SSizes.small),
      decoration: BoxDecoration(
          color: isCurrentUser ? SColors.primary : SColors.barderPrimary ,
          borderRadius: isCurrentUser ? const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
          : const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),),
      child: Text(message,style:TextStyle(color: isCurrentUser ? Colors.white : Colors.black),),
    );
  }
}

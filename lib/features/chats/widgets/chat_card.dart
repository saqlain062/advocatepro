import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/features/chats/chat_screen.dart';
import 'package:advocatepro_f/features/client/models/chat/chat_model.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chat;
  const ChatCard({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      elevation: 0.5,
      color: SColors.white,
      child: InkWell(
        onTap: () {
            Get.to(ChatScreen(chat: chat));
        },
        child: ListTile(
          leading: const SCircularImage(image: SImages.darkAppLogo),
          title: Text(chat.lawyer.title),
          subtitle: Text(chat.about),
          trailing: Text(
            chat.isOnline ?? '',
            style: const TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}

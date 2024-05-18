import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/data/repositories/chat/chat_repository.dart';
import 'package:advocatepro_f/features/client/models/chat/chat_model.dart';
import 'package:advocatepro_f/features/client/models/chat/message_model.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/images/s_circular_image.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/device/device_utility.dart';
import 'widgets/message_card.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.chat,
    
  });
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final repo = Get.put(ChatRepository());
    return SafeArea(
      child: Scaffold(
        appBar: SChatAppBar(chat:chat),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: repo.getMessage(
                      AuthenticationRepository.instance.authUser!.uid,
                      chat.lawyer.id),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox();
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                       final messageList = data
                                ?.map((e) => Message.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .toList() ??
                            [];

                        if (messageList.isNotEmpty) {
                          return ListView.builder(
                              itemCount: messageList.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MessageCard(message: messageList[index]);
                              });
                        } else {
                          return const Text("Start your conservation");
                        }
                    }
                  }),
            ),
            SUserInput(lawyerChatId: chat.lawyer.id),
          ],
        ),
      ),
    );
  }
}

class SUserInput extends StatelessWidget {
  SUserInput({
    super.key,
    required this.lawyerChatId,
  });

  final TextEditingController messageController = TextEditingController();
  final String lawyerChatId;
  @override
  Widget build(BuildContext context) {
    final repo = Get.put(ChatRepository());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.small),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.emoji_emotions_outlined)),
                  Expanded(
                      child: TextField(
                    controller: messageController,
                    obscureText: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Message',
                    ),
                  )),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.image_outlined)),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.camera_alt_outlined)),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                repo.sendMessage(lawyerChatId, messageController.text.trim());
                messageController.text = '';
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: SColors.primary,
            child: const Icon(
              Icons.send,
              color: SColors.iconColorin,
            ),
          )
        ],
      ),
    );
  }
}

class SChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SChatAppBar({
    super.key, required this.chat,
  });
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: InkWell(
        onTap: () {},
        child: Row(
          children: [
            IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back)),
            SCircularImage(image: chat.lawyer.thumbnail.isNotEmpty ? chat.lawyer.thumbnail : SImages.noimage,isNetworkImage: chat.lawyer.thumbnail.isNotEmpty,),
            const SizedBox(
              width: SSizes.spaceBetweenItems / 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat.lawyer.title,
                    style: Theme.of(context).textTheme.headlineMedium),
                Text(
                  'Last Seen',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  @override
  Size get preferredSize => Size.fromHeight(SDeviceUtils.getAppBarHeight());
}

/* static Future<bool> chatExits() async {
  return (await firestore.collection('Chat').doc(lawyer.id).get()).exits;

}

static Future<bool> createchat() asyn {
  final time = DateTime.now().mise.tosting();
  final chatUser = Chatuser(
    id L user.id,

  );
  return (await fire.collec('chat').doc(aut).set(chatuser.tojson()))
}*/
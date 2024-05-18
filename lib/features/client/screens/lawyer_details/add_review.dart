import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/color.dart';
import '../../../../utils/constants/sizes.dart';

class AddReviewInput extends StatelessWidget {
  AddReviewInput({
    super.key,
  });

  final TextEditingController messageController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
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
                      // repo.sendMessage(lawyerChatId, messageController.text);
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
          ),
        ],
      ),
    );
  }
}

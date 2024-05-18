
import 'package:advocatepro_f/common/widgets/texts/section_heading.dart';
import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:advocatepro_f/features/chats/chat_screen.dart';
import 'package:advocatepro_f/features/client/models/chat/chat_model.dart';
import 'package:advocatepro_f/features/client/models/lawyer_model.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_details/widgets/lawyer_detail_image_slider.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_details/widgets/lawyer_meta_data.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_details/widgets/rating_share_widget.dart';
import 'package:advocatepro_f/features/client/screens/lawyer_reviews/lawyer_reviews.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/chat/inbox_repository.dart';

class LawyerDetailScreen extends StatelessWidget {
  const LawyerDetailScreen({super.key, required this.lawyer});

  final LawyerModel lawyer;
  
  @override
  Widget build(BuildContext context) {
    
    final repo = Get.put(InboxRepository());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Lawyer Image Slider
            SLawyerImageSlider(lawyer: lawyer,),

            /// Lawyer Details
            Padding(padding: const EdgeInsets.only(right: SSizes.defaultSpaces , left: SSizes.defaultSpaces, bottom: SSizes.defaultSpaces),
            child: Column(
              children: [
                /// - Rating & Share Button
                const SRatingAndShare(),

                /// - Title and Description
                SLawyerMetaData(lawyer: lawyer,),

                /// - Button
                const Divider(),
                const SizedBox(height: SSizes.spaceBetweenItems,),
                SizedBox(width: double.infinity,
                child: ElevatedButton(onPressed: () async {
                  final check = await repo.alreadyChat(lawyer.id);
                  ChatModel chatModel = ChatModel(
                    createdAt: DateTime.now().toString(),
                    isOnline: 'true',  // replace with actual value
                    lastActive: false,  // replace with actual value
                    pushToken: '',  // replace with actual value
                    about: lawyer.spec ?? '',
                    email: '',  // replace with actual value
                    lawyer: lawyer,
                  );
                  if(check){
                    Get.to(ChatScreen(chat: chatModel, ));
                    print('------------------check value$check');
                    print(AuthenticationRepository.instance.authUser!.uid);
                    print(lawyer.id);
                  } else {
                    print(lawyer.id);
                    await repo.setSdata(lawyer);
                    await repo.setRdata(lawyer,lawyer);
                    print('--------------checknot$check');
                  Get.to(ChatScreen(chat: chatModel,));
                  }
                  
                }, child: const Text('Message')),),
                const SizedBox(height: SSizes.spaceBetweenItems,),

                /// - Reviews
                
                SSectionHeading(title: 'Reviews(199)', onPressed: () => Get.to(() => const LawyerReviews()),),
                const SizedBox(height: SSizes.spaceBetweenSections,)

              ],
            ),)
          ],
        ),
      ),
    );
  }
}

import 'package:advocatepro_f/features/chats/widgets/chat_card.dart';
import 'package:advocatepro_f/features/client/models/chat/chat_model.dart';
import 'package:advocatepro_f/features/client/screens/lawyer/lawyer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/chat/inbox_repository.dart';

class InboxScreen extends StatefulWidget {
  static const String id = 'inbox_screen';
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    
    final repo = Get.put(InboxRepository());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const LawyerScreen()),
        child: const Icon(Icons.add_box_rounded),
      ),
      body: StreamBuilder(
          stream: repo.getChat(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                print('-------------$data');
                final list = data?.map((e) => ChatModel.fromSnapshot(e.data() as Map<String,dynamic>)).toList() ?? [];

                if(list.isNotEmpty){
                  return ListView.builder(
                    itemCount: list.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatCard(chat: list[index]);
                    });
                } else {
                  return const Text("There is No chat");
                }
                
            }
          }),
    );
  }
}

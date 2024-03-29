import 'package:advocatepro_f/features/bottom/inbox/chat_screen.dart';
import 'package:advocatepro_f/features/home/home_client_post_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InboxScreen extends StatefulWidget {
  static const String id = 'inbox_screen';
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inbox'),
          // backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<String>>(
          future: _fetchMessages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading message'));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FirebaseAnimatedList(
                          query: FirebaseDatabase.instance
                              .ref('Post_${uid()}_profile'),
                          defaultChild:
                              const Center(child: CircularProgressIndicator()),
                          itemBuilder: (context, snapshots, animation, index) {
                            final imageUrl =
                                snapshots.child('url').value.toString();
                            return CircleAvatar(
                                radius: 50,
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        height: 100,
                                        width: 100,
                                      )
                                    : const CircularProgressIndicator());
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'No Messages Yet',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Text(
                        'Send your first message. You\'ll find your conversations all right here',
                        style: TextStyle(fontSize: 16),
                      ),
                    ]),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  String message = snapshot.data![index];
                  // Get the current time
                  String currentTime =
                      DateFormat('h:mm a').format(DateTime.now());

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(chatName: message),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  message,
                                ),
                              ),
                              Text(currentTime)
                            ],
                          ),
                          subtitle: const Text('message in the chat'),
                        ),
                        const Divider(), // Add a divider between each ListTile
                      ],
                    ),
                  );
                },
              );
            }
          },
        ));
  }

  //fetching messages from a database
  Future<List<String>> _fetchMessages() async {
    await Future.delayed(Duration(seconds: 2)); //Simulating delay
    return ["Message 1", "Message 2"];
  }
}

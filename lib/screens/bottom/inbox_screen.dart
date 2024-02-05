import 'package:flutter/material.dart';

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
                      Image.asset(
                        'images/lawyerIcon.png',
                        height: 100,
                      ),
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
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(snapshot.data![index],),
                  );

              });
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

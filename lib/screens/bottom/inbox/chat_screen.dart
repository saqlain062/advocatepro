  import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String id = 'chat_screen';
  final String chatName;

  const ChatScreen({super.key, required this.chatName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatName), // Display the name of the chat
      ),
      body: Center(
        child: Text('Chat with $chatName'), // Placeholder for chat messages
      ),
    );
  }
}

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
      ),
    );
  }
}

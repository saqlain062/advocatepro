import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Getting Started with the App',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: const Text(
              'Learn how to get started with our app.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // Handle article tap
            },
          ),
          ListTile(
            title: const Text(
              'Advanced Features Guide',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: const Text(
              'Explore advanced features and functionalities.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // Handle article tap
            },
          ),
          // Add more articles as needed
        ],
      ),
    );
  }
}

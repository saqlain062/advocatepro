import 'package:flutter/material.dart';

class AdvocateProfileScreen extends StatelessWidget {
  const AdvocateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Lawyer Name',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.verified_user, color: Colors.green), //
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('images/lawyerIcon.png'),
            ),
            const Text(
              'Contact Info',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle request appointment action
              },
              child: const Text('Request Appointment'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle add to business action
              },
              child: const Text('Add to Business'),
            ),
            // Add verified badge icon

            // Display lawyer posts
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Example count of posts
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Post ${index + 1}'),
                      subtitle: const Text('Details of the post'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

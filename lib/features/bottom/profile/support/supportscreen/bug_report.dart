import 'package:flutter/material.dart';

class BugReportingScreen extends StatelessWidget {
  const BugReportingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bug Reporting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Which error you are facing write here!',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your bug here...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                // Implement logic to capture user's text input
              ),
              const SizedBox(height: 20),
              const Text(
                'You can also upload screenshots:',
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement screenshot upload logic
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Upload Screenshot'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement feedback submission logic
                },
                icon: const Icon(Icons.send),
                label: const Text('Submit'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

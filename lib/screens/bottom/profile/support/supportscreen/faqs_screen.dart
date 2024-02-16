import 'package:flutter/material.dart';

class FAQsScreen extends StatelessWidget {
  final List<String> faqs = [
    "How do I reset my password?",
    "How can I update my profile information?",
    "What payment methods do you accept?",
    "Is there a mobile app available?",
    "How do I contact customer support?",
  ];

  final List<String> answers = [
    "To reset your password, navigate to the 'Forgot Password' section on the login page and follow the instructions provided.",
    "You can update your profile information by accessing the 'Profile' section in the app settings.",
    "We accept various payment methods including credit/debit cards, PayPal, and bank transfers.",
    "Yes, we have a mobile app available for both Android and iOS devices. You can download it from the respective app stores.",
    "You can contact customer support by emailing support@example.com or calling +1234567890.",
  ];

  FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          
          return ExpansionTile(
            backgroundColor: Colors.blue[50],
            title: Text(
              faqs[index],
              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  answers[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

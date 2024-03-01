import 'package:advocatepro_f/features/bottom/profile/support/supportscreen/bug_report.dart';
import 'package:advocatepro_f/features/bottom/profile/support/supportscreen/contact_information_screen.dart';
import 'package:advocatepro_f/features/bottom/profile/support/supportscreen/faqs_screen.dart';
import 'package:advocatepro_f/features/bottom/profile/support/supportscreen/feedback_screen.dart';
import 'package:advocatepro_f/features/bottom/profile/support/supportscreen/live_chat.dart';
import 'package:advocatepro_f/features/bottom/profile/support/supportscreen/tutorial_screen.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOptionCard(
              title: 'FAQs (Frequently Asked Questions)',
              description:
                  'Create a list of commonly asked questions and their answers. Organize them into categories for easy navigation. Include a search bar to allow users to quickly find relevant FAQs.',
              icon: Icons.question_answer,
              screen: FAQsScreen(),
            ),
            _buildOptionCard(
              title: 'Contact Information',
              description:
                  'Provide contact details such as email address, phone number, and physical address. Consider integrating a "Contact Us" form within the app for users to send messages directly.',
              icon: Icons.contact_mail,
              screen: const ContactInfoScreen(),
            ),
            _buildOptionCard(
              title: 'Live Chat or Messaging',
              description:
                  'Implement a live chat feature to allow users to communicate with support agents in real-time. Alternatively, integrate a messaging system where users can send and receive messages asynchronously.',
              icon: Icons.chat,
              screen: const LiveChatScreen(),
            ),
            _buildOptionCard(
              title: 'Help Articles and Tutorials',
              description:
                  'Offer guides, tutorials, and how-to articles to help users understand your app\'s features and functionalities better. Include step-by-step instructions with screenshots or videos for clarity.',
              icon: Icons.library_books,
              screen: const TutorialScreen(),
            ),
            _buildOptionCard(
              title: 'Feedback and Suggestions',
              description:
                  'Allow users to provide feedback and suggestions directly within the app. Implement a feedback form or a dedicated feedback section where users can share their thoughts and ideas.',
              icon: Icons.feedback,
              screen:const FeedbackScreen(),
            ),
            _buildOptionCard(
              title: 'Bug Reporting',
              description:
                  'Enable users to report bugs or technical issues they encounter. Include a bug reporting form with fields for describing the problem and attaching screenshots if necessary.',
              icon: Icons.bug_report,
              screen: const BugReportingScreen(),
            ),
          ],
        ),
      ),
    );
  }
   Widget _buildOptionCard({
    required String title,
    required String description,
    required IconData icon, 
    required screen,
  }) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      child: ListTile(
        leading: Icon(icon, size: 36),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}
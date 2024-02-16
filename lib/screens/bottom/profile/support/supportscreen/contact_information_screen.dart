import 'package:flutter/material.dart';

class ContactInfoScreen extends StatelessWidget {
  const ContactInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(
              height: 100,
              width: 100,
               child: Image.asset(
                        'images/lawyerIcon.png', // Path to your image asset
                        fit: BoxFit.cover,
                        
                      ),
             ),
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Email: saqlain.asif@gmail.com',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'WhatsApp: +92 44 3383306',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Address: Kalaswala Road Opposite Nawaz \n Shareef Park, Pasrur, Sialkot, Pakistan',
              style: TextStyle(fontSize: 18),
            ),
            // Add a "Contact Us" button for the form
          ],
        ),
      ),
    );
  }
}

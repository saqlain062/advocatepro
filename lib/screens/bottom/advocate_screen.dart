
import 'package:flutter/material.dart';

class AdvocateScreen extends StatefulWidget {
  static const String id = 'advocate_scree';
  const AdvocateScreen({super.key});

  @override
  State<AdvocateScreen> createState() => _AdvocateScreenState();
}

class _AdvocateScreenState extends State<AdvocateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Best Advocate'),
        // backgroundColor: Colors.blue,
        
      ),
    );
  }
}
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePostScreen extends StatefulWidget {
  const HomePostScreen({super.key});

  @override
  State<HomePostScreen> createState() => _HomePostScreenState();
}

class _HomePostScreenState extends State<HomePostScreen> {
  final ref = FirebaseDatabase.instance.ref(databasePathPost());
  bool verified = false;
  String imageUrl = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child("users/${uid()}/profile-pic.jpg");
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: CircleAvatar(
            radius: 25,
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                  )
                : const CircularProgressIndicator()),
        backgroundColor: colorAppbar,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'AdvocatePro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Category",style: TextStyle(fontSize: SSizes.fontSizeLg),),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _category(title: "Family", screen: const Text("") ),
                  _category(title: "Criminal", screen: const Text("") ),
                  _category(title: "Priviate", screen: const Text("") ),
                  _category(title: "Divorce", screen: const Text("") ),
                ],
              ),
            ),
            const Text("NearBy",style: TextStyle(fontSize: SSizes.fontSizeLg),),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children : [
                _nearBy(title: 'Saqlain', subtitle: 'Lawyer', icon: Icons.access_alarms_sharp, imageUrl: SImages.darkAppLogo, screen: const Text('data')),
                ]
                
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _category({
    required String title,
    required Widget screen,
  }) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      surfaceTintColor: colorWhite,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _nearBy({
    required String imageUrl,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget screen,
  }) {
    return Stack(
      children: [
    // Background image
    Image.asset(
      imageUrl,
      height: 150,
      width: 150,
    ),
    // White background for profile info
    Positioned(
      top: 100,
      left: 15,
      right: 15,
      bottom: -2,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SSizes.fontSizeMd,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 10),
            ),
            Row(
              children: [
                Icon(icon, color: Colors.grey),
                const SizedBox(width: 4),
                const Text(
                  '+1234567890',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
      ],
    );

  }
}

String? userName() {
  String? username = FirebaseAuth.instance.currentUser!.displayName;
  return username;
}

String? uid() {
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  return uid;
}

String databasePathPost() {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String databasePath = 'Post_$uid';
  return databasePath;
}

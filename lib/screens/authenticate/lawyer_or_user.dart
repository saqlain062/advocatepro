import 'package:advocatepro_f/screens/authenticate/sign_up_attribute.dart';
import 'package:advocatepro_f/screens/home/home_client_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LawyerOrUserScreen extends StatefulWidget {
  const LawyerOrUserScreen({super.key});

  @override
  State<LawyerOrUserScreen> createState() => _LawyerOrUserScreenState();
}

class _LawyerOrUserScreenState extends State<LawyerOrUserScreen> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController controllerLawyerID = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool boolSignUpSuccessfull = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Column(children: [
                const Image(
                    height: 100,
                    width: 100,
                    image: AssetImage(SImages.lightAppLogo)),
                const Center(
                    child: Text(
                  'who are you ...',
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 170,
                  child: ListView(
                    children: [
                      Card(
                        elevation: 2,
                        child: ListTile(
                          leading: const Icon(
                            Icons.person_pin_outlined
                          ),
                          title: const Text('Lawyer'),
                          trailing: const Icon(Icons.navigate_next_outlined),
                          subtitle: const Text("Select if you are lawyer"),
                          onTap: () {
                            _insertLawyerData();
                            // Handle Option 1 selection
                            print('Option 1 selected');
                          },
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: ListTile(
                          leading: const Icon(Icons.person_3_outlined),
                          title: const Text('Client'),
                          trailing: const Icon(Icons.navigate_next_outlined),
                          subtitle: const Text('Select if you are Client or regular user'),
                          onTap: () {
                            _insertUserData();
                            // Handle Option 2 selection
                            print('Option 2 selected');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Signup Button
              ]),
            )),
      ),
    );
  }

  _insertUserData() async {
    // Access the signed-in user's information
    final user = _firebaseAuth.currentUser;
    final name = user?.displayName; // User's display name
    final email = user?.email; // User's email address
    final url = user?.photoURL;
    // Store user data in Firestore
      final userCollection = FirebaseFirestore.instance
          .collection("users");
      final newUser = SignupAttribute(
        id: user!.uid,
        fname: name ?? '',
        lname: '',
        phone: user.phoneNumber ?? '',
        email: email ?? '',
        laywerOrNot: 'User or Client',
        specialization: 'Google Sign in',
        dateofbirth: 'Google Sign in',
        profilePhotoUrl: url ?? '',
      ).toJson();
      await userCollection.doc(user.uid).set(newUser);
      Navigator.pushNamed(context, ClientHomeScreen.id);
    
  }

  _insertLawyerData() async {
    // Access the signed-in user's information
    final user = _firebaseAuth.currentUser;
    final name = user?.displayName; // User's display name
    final email = user?.email; // User's email address
    final url = user?.photoURL;
    final lawyerCollection = FirebaseFirestore.instance
        .collection("lawyers");
    final newUser = SignupAttribute(
      id: user!.uid,
      fname: name ?? '',
      lname: '',
      phone: user.phoneNumber ?? '',
      email: email ?? '',
      laywerOrNot: 'Lawyer',
      specialization: 'Google Sign in',
      dateofbirth: 'Google Sign in',
      profilePhotoUrl: url ?? '',
    ).toJson();
    await lawyerCollection.doc(user.uid).set(newUser);
    Navigator.pushNamed(context, HomeScreen.id);
  }
}

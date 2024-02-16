// import 'package:advocatepro_f/screens/authenticate/sign_up_attribute.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// void insertSignupData() {
//   String uid = FirebaseAuth.instance.currentUser!.uid;
//   print("------------------------");
//   print(uid);
//   final userCollection = FirebaseFirestore.instance
//       .collection("users")
//       .doc(uid)
//       .collection("profile_data");
//   final newUser = SignupAttribute(
//     id: uid,
//     fname: controllerFirstName.text,
//     lname: controllerSecondName.text,
//     phone: controllerPassword.text,
//     email: controllerEmail.text,
//     laywerOrNot: lawyerID,
//     specialization: lawyerID,
//     dateofbirth: lawyerID,
//   ).toJson();
//   userCollection.doc(uid).set(newUser);
//   print(newUser);
//   print(userCollection);
// }

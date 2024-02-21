import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/screens/authenticate/sign_up_attribute.dart';
import 'package:advocatepro_f/screens/bottom/advocate_attaribute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileAttribute {
  AdvocateAttribute object;
  final String email;
  final String phone;
  final String dateofbirth;

  ProfileAttribute({
    required this.object,
    required this.email,
    required this.phone,
    required this.dateofbirth,
  });
  factory ProfileAttribute.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProfileAttribute(
        object: AdvocateAttribute(
            id: data?['ID'],
            fname: data?['First Name'],
            lname: data?['Last Name'],
            specialization: data?['Specilization']),
        email: data?['Email'],
        phone: data?['Phone'],
        dateofbirth: data?['DOB']
        // regions:
        //     data?['regions'] is Iterable ? List.from(data?['regions']) : null,
        );
  }
}

Future<List<SignupAttribute>> fetchDataOfCurrentUser() async {
  List<SignupAttribute> profileList = [];
   try {
    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;
    
    // Check if the user is a lawyer
    DocumentSnapshot<Map<String, dynamic>> userDocLawyerCollection =
        await FirebaseFirestore.instance.collection('lawyers').doc(uid).get();

    if (userDocLawyerCollection.exists) {
      profileList.add(SignupAttribute(
        id: userDocLawyerCollection['ID'] ?? '',
        fname: userDocLawyerCollection["First Name"] ?? '',
        lname: userDocLawyerCollection['Last Name'] ?? '',
        specialization: userDocLawyerCollection['Specialization'] ?? '',
        laywerOrNot: userDocLawyerCollection['Lawyer ID'] ?? '',
        email: userDocLawyerCollection['Email'] ?? '',
        phone: userDocLawyerCollection['Phone'] ?? '',
        dateofbirth: userDocLawyerCollection['DOB'] ?? '',
      ));
    } else {
      // User is not a lawyer, check if the user exists in the 'users' collection
      DocumentSnapshot<Map<String, dynamic>> userDocUserCollection =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDocUserCollection.exists) {
        profileList.add(SignupAttribute(
          id: userDocUserCollection['ID'] ?? '',
          fname: userDocUserCollection["First Name"] ?? '',
          lname: userDocUserCollection['Last Name'] ?? '',
          specialization: userDocUserCollection['Specialization'] ?? '',
          laywerOrNot: userDocUserCollection['Lawyer ID'] ?? '',
          email: userDocUserCollection['Email'] ?? '',
          phone: userDocUserCollection['Phone'] ?? '',
          dateofbirth: userDocUserCollection['DOB'] ?? '',
        ));
      } else {
        showToast(message: "No data found for the current user");
      }
    }
  } catch (e) {
    print('---------E-----------$e');
    showToast(message: 'Error fetching data: $e');
  }
  print(profileList);
  return profileList;
}

Future<List<ProfileAttribute>> fetchDataOfAllLawyers() async {
  List<ProfileAttribute> profileList = [];
  try {
    // Get a reference to the Firestore collection
    CollectionReference<Map<String, dynamic>> lawyersCollection =
        FirebaseFirestore.instance.collection('lawyers');
    // Get the documents in the collection
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await lawyersCollection.get();
        print(querySnapshot.size);

    // Iterate through the documents in the collection
    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in querySnapshot.docs) {

      // Get the subcollection 'profile_data' for each lawyer
      CollectionReference<Map<String, dynamic>> profileCollection =
          documentSnapshot.reference.collection('profile_data');

      // Get the documents in the 'profile_data' subcollection
      QuerySnapshot<Map<String, dynamic>> profileSnapshot =
          await profileCollection.get();

      // Check if there are any profile documents
      if (profileSnapshot.docs.isNotEmpty) {
        // Get the first profile document
        QueryDocumentSnapshot<Map<String, dynamic>> profileDoc =
            profileSnapshot.docs.first;

        // Access data fields from the profile document
        var data = profileDoc.data();
        // Create ProfileAttribute object
        ProfileAttribute profileAttribute = ProfileAttribute(
          object: AdvocateAttribute(
            id: data['ID'] ?? '',
            fname: data["First Name"] ?? '',
            lname: data['Last Name'] ?? '',
            specialization: data['Specialization'] ?? '',
            // Add more fields as needed
          ),
          email: data['Email'] ?? '',
          phone: data['Phone'] ?? '',
          dateofbirth: data['DOB'] ?? '',
        );
        // Add the ProfileAttribute object to the list
        profileList.add(profileAttribute);
      }
    }
  } catch (e) {
    print('Error fetching data: $e');
    showToast(message: 'Error fetching data: $e');
  }
  return profileList;
}

import 'package:advocatepro_f/Methods/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdvocateFields{
  static const String id = 'ID';
  static const String fname = 'First Name';
  static const String lname = 'Last Name';
  static const String specialization = 'Specialization';
  // static const String phone = 'Phone';
  // static const String email= 'Email';
  // static const String laywerOrNot = 'Lawyer ID';
  static List<String> getFields() => [id,fname,lname,specialization];
}

class AdvocateAttribute {
  final String id;
  final String fname;
  final String lname;
  final String specialization;

  const AdvocateAttribute({
    required this.id,
    required this.fname,
    required this.lname,
    required this.specialization,
  });

  static AdvocateAttribute fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot){
    return AdvocateAttribute(id: snapshot["ID"], fname: snapshot['First Name'], lname: snapshot['Last Name'], specialization: snapshot['Specialization']);
  }

  static AdvocateAttribute formJson (Map<String, dynamic> byId) {
    return AdvocateAttribute(
    id: byId[AdvocateFields.id],
    fname: byId[AdvocateFields.fname],
    lname: byId[AdvocateFields.lname],
    specialization: byId[AdvocateFields.specialization]
    // phone: byId[AdvocateFields.phone],
    // email:byId[AdvocateFields.email],
    // laywerOrNot: byId[AdvocateFields.laywerOrNot],
  );
  }

  Map<String, dynamic > toJson() => {
    AdvocateFields.id: id,
    AdvocateFields.fname: fname,
    AdvocateFields.lname: lname,
    // AdvocateFields.phone: phone,
    // AdvocateFields.email: email,
    // AdvocateFields.laywerOrNot: laywerOrNot,
  };
}

Future<List<AdvocateAttribute>> fetchDataFromLawyersCollection() async {
  List<AdvocateAttribute> lawyersList = [];
  try {
    // Get a reference to the Firestore collection
    CollectionReference<Map<String, dynamic>> lawyersCollection =
        FirebaseFirestore.instance.collection('lawyers');
    // Get the documents in the collection
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await lawyersCollection.get();
        print(querySnapshot);
    final lawyers = querySnapshot.docs.map((e) => AdvocateAttribute.fromSnapshot(e))
    .toList();
    print("------------------${lawyers[0]}");
    // Iterate through the documents and fetch profile data from subcollection
    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in querySnapshot.docs) {
          print(documentSnapshot.data());
      // Reference the 'profile_data' subcollection for each lawyer
      CollectionReference<Map<String, dynamic>> profileCollection =
          documentSnapshot.reference.collection('profile_data');
      // Get the documents in the 'profile_data' subcollection
      QuerySnapshot<Map<String, dynamic>> profileSnapshot =
          await profileCollection.get();
          print('---------------${profileCollection.doc}');
      // Iterate through the profile documents and create AdvocateAttribute objects
      for (QueryDocumentSnapshot<Map<String, dynamic>> profileDoc
          in profileSnapshot.docs) {
             print('------p---------${profileCollection.doc()}');
        // Access data fields from the profile document
        var data = profileDoc.data();
        // Create AdvocateAttribute object
        AdvocateAttribute lawyerProfile = AdvocateAttribute(
          id: data['ID'] ?? '',
          fname: data['First Name'] ?? '',
          lname: data['Last Name'] ?? '',
          specialization: data['Specialization'] ?? '',
          // Add more fields as needed
        );
        // Add the AdvocateAttribute object to the list
        lawyersList.add(lawyerProfile);
      }
    }
    // Print retrieved data for debugging
  } catch (e) {
    print('----------------$e');
    showToast(message: "ad Error fetching data: $e");
  }
  print(lawyersList);
  return lawyersList;
}

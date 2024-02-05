// class AdvocateFields{
//   static const String id = 'ID';
//   static const String fname = 'Fast Name';
//   static const String lname = 'Last Name';
//   static const String phone = 'Phone';
//   static const String email= 'Email';
//   static const String laywerOrNot = 'Lawyer ID';
//   static List<String> getFields() => [id,fname,lname,phone,email,laywerOrNot];
// }

import 'package:advocatepro_f/Methods/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // static AdvocateAttribute formJson (DocumentSnapshot<Map<String, dynamic>> byId) {
  //   return AdvocateAttribute(
  //   id: jsonDecode(byId[AdvocateFields.id]),
  //   fname: byId[AdvocateFields.fname],
  //   lname: byId[AdvocateFields.lname],
  //   phone: byId[AdvocateFields.phone],
  //   email:byId[AdvocateFields.email],
  //   laywerOrNot: byId[AdvocateFields.laywerOrNot],
  // );
  // }

  // Map<String, dynamic > toJson() => {
  //   AdvocateFields.id: id,
  //   AdvocateFields.fname: fname,
  //   AdvocateFields.lname: lname,
  //   AdvocateFields.phone: phone,
  //   AdvocateFields.email: email,
  //   AdvocateFields.laywerOrNot: laywerOrNot,
  // };
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

    // Iterate through the documents and create Lawyer objects
    lawyersList = querySnapshot.docs.map((doc) {
      return AdvocateAttribute(
        id: doc.id,
        fname: doc['First Name'] ?? '',
        lname: doc['Last Name'] ?? '',
        specialization: doc['ID'] ?? '',
        // Add more fields as needed
      );
    }).toList();
  } catch (e) {
    showToast(message: "Error fetching data: $e");
  }
  return lawyersList;
}

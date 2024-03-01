import 'package:cloud_firestore/cloud_firestore.dart';

class AdvocateFields{
  static const String id = 'ID';
  static const String fname = 'First Name';
  static const String lname = 'Last Name';
  static const String specialization = 'Specialization';
  static const String phone = 'Phone';
  static const String email= 'Email';
  static const String dateofbirth = 'DOB';
  // static const String laywerOrNot = 'Lawyer ID';
  static List<String> getFields() => [id,fname,lname,specialization];
}

class AdvocateAttribute {
  final String id;
  final String fname;
  final String lname;
  final String specialization;
  final String? email;
  final String? phone;
  final String? dateofbirth;

  const AdvocateAttribute({
    required this.id,
    required this.fname,
    required this.lname,
    required this.specialization,
    this.email,
    this.phone,
    this.dateofbirth,
  });

  static AdvocateAttribute fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot){
    return AdvocateAttribute(id: snapshot["ID"], fname: snapshot['First Name'], lname: snapshot['Last Name'], specialization: snapshot['Specialization'],
    email: snapshot['Email'],
        phone: snapshot['Phone'],
        dateofbirth: snapshot['DOB']);
  }

  static AdvocateAttribute formJson (Map<String, dynamic> byId) {
    return AdvocateAttribute(
    id: byId[AdvocateFields.id],
    fname: byId[AdvocateFields.fname],
    lname: byId[AdvocateFields.lname],
    specialization: byId[AdvocateFields.specialization],
    phone: byId[AdvocateFields.phone],
    email:byId[AdvocateFields.email],
    dateofbirth: byId[AdvocateFields.dateofbirth],
  );
  }

  Map<String, dynamic > toJson() => {
    AdvocateFields.id: id,
    AdvocateFields.fname: fname,
    AdvocateFields.lname: lname,
    AdvocateFields.phone: phone,
    AdvocateFields.email: email,
    AdvocateFields.dateofbirth: dateofbirth,
  };
}

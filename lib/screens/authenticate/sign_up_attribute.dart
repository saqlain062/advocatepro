import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SignupFields {
  static const String id = 'ID';
  static const String fname = 'Fast Name';
  static const String lname = 'Last Name';
  static const String phone = 'Phone';
  static const String email = 'Email';
  static const String laywerOrNot = 'Lawyer ID';
  static List<String> getFields() =>
      [id, fname, lname, phone, email, laywerOrNot];
}

class SignupAttribute {
  final String id;
  final String fname;
  final String lname;
  final String phone;
  final String email;
  final String laywerOrNot;

  const SignupAttribute({
    required this.id,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.email,
    required this.laywerOrNot,
  });

  static SignupAttribute formJson(DocumentSnapshot<Map<String, dynamic>> byId) {
    return SignupAttribute(
      id: jsonDecode(byId[SignupFields.id]),
      fname: byId[SignupFields.fname],
      lname: byId[SignupFields.lname],
      phone: byId[SignupFields.phone],
      email: byId[SignupFields.email],
      laywerOrNot: byId[SignupFields.laywerOrNot],
    );
  }

  Map<String, dynamic> toJson() => {
        SignupFields.id: id,
        SignupFields.fname: fname,
        SignupFields.lname: lname,
        SignupFields.phone: phone,
        SignupFields.email: email,
        SignupFields.laywerOrNot: laywerOrNot,
      };
}

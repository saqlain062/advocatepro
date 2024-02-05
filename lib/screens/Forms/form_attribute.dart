import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FormFields {
  static const String id = 'ID';
  static const String serial = 'List Number';
  static const String name = 'Name';
  static const String phone = 'Phone';
  static const String previousDate = 'Previous Date';
  static const String nextAppearance = 'Next Appearance';
  static const String nextAction = 'Next Action';
  static List<String> getFields() =>
      [id, serial, name, phone, previousDate, nextAppearance, nextAction];
}

class FormAttribute {
  final String? id;
  final String? serial;
  final String name;
  final String phone;
  final String previousDate;
  final String nextAppearance;
  final String? nextAction;

  const FormAttribute(
      {this.id,
      this.serial,
      required this.name,
      required this.phone,
      required this.previousDate,
      required this.nextAppearance,
      this.nextAction});

  static FormAttribute formJson(DocumentSnapshot<Map<String, dynamic>> byId) {
    return FormAttribute(
      id: jsonDecode(byId[FormFields.id]),
      serial: jsonDecode(byId[FormFields.serial]),
      name: byId[FormFields.name],
      phone: byId[FormFields.phone],
      previousDate: byId[FormFields.previousDate],
      nextAppearance: byId[FormFields.nextAppearance],
      nextAction: byId[FormFields.nextAction],
    );
  }

  Map<String, dynamic> toJson() => {
        FormFields.id: id,
        FormFields.serial: serial,
        FormFields.name: name,
        FormFields.phone: phone,
        FormFields.previousDate: previousDate,
        FormFields.nextAppearance: nextAppearance,
        FormFields.nextAction: nextAction,
      };
}

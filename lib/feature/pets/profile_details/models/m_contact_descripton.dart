import 'package:flutter/material.dart';
import 'package:userapp/general/utils_color/hex_color.dart';

class ContactDescription {
  final int contactDescriptionId;
  String contactDescriptionLabel;
  String contactDescriptionHex;
  final DateTime creationDateTime;
  final DateTime updatedDateTime;

  ContactDescription(
    this.contactDescriptionId,
    this.contactDescriptionLabel,
    this.contactDescriptionHex,
    this.creationDateTime,
    this.updatedDateTime,
  );

  ContactDescription.fromJson(Map<String, dynamic> json)
      : contactDescriptionId = json['contact_description_id'],
        contactDescriptionLabel = json['contact_description_label'],
        contactDescriptionHex = json['contact_description_hex'],
        creationDateTime =
            DateTime.parse(json['contact_description_creation_DateTime']),
        updatedDateTime =
            DateTime.parse(json['contact_description_updated_DateTime']);

  Map<String, dynamic> toJson() => {
        'contact_description_id': contactDescriptionId,
        'contact_description_label': contactDescriptionLabel,
        'contact_description_hex': contactDescriptionHex,
      };
}

List<Color> getAvailableContactDescriptionColors() {
  //Material default Colors
  List<Color> _defaultColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.brown.shade700,
    Colors.grey,
    Colors.blueGrey,
  ];
  return _defaultColors;
}

Color getDefaultColor() {
  return Colors.purple;
}

String getDefaultLabel() {
  return "Other";
}

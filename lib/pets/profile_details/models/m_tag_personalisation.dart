import 'package:flutter/material.dart';

class CollarTagPersonalisation {
  final int collarTagPersonalisationId;
  final String collarTagId;
  final Color primaryColor;
  final Color secondaryColor;
  final Color baseColor;
  final String letter;
  //!Change to Font Family
  final String letterStyle;

  CollarTagPersonalisation(
    this.collarTagPersonalisationId,
    this.collarTagId,
    this.primaryColor,
    this.secondaryColor,
    this.baseColor,
    this.letter,
    this.letterStyle,
  );

  CollarTagPersonalisation.fromJson(Map<String, dynamic> json)
      : collarTagPersonalisationId = json['collarTagPersonalisationId'],
        collarTagId = json['collarTag_id'],
        primaryColor = parseTagColor(json['primaryColor']),
        secondaryColor = parseTagColor(json['secondaryColor']),
        baseColor = parseTagColor(json['baseColor']),
        letter = json['letter'],
        letterStyle = json['letterStyle'];
}

Color parseTagColor(String value) {
  switch (value) {
    case "PINK":
      return Colors.pink;
    case "GREEN":
      return Colors.green;
    case "BLACK":
      return Colors.black;
    default:
      return Colors.yellow;
  }
}

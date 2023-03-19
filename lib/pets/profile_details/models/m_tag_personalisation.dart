import 'package:flutter/material.dart';
import 'package:userapp/pet_color/hex_color.dart';

class TagPersonalisation {
  final int collarTagPersonalisationId;
  final String collarTagId;
  final String primaryColorName;
  final String secondaryColorName;
  final String baseColorName;
  final String letter;
  //!Change to Font Family
  final String letterStyle;
  final Color petPageBackgroundColor;
  final Color primaryColor;
  final Color secondaryColor;

  TagPersonalisation(
    this.collarTagPersonalisationId,
    this.collarTagId,
    this.primaryColorName,
    this.secondaryColorName,
    this.baseColorName,
    this.letter,
    this.letterStyle,
    this.petPageBackgroundColor,
    this.primaryColor,
    this.secondaryColor,
  );

  TagPersonalisation.fromJson(Map<String, dynamic> json)
      : collarTagPersonalisationId = json['collarTagPersonalisationId'],
        collarTagId = json['collarTag_id'],
        primaryColorName = json['primaryColorName'],
        secondaryColorName = json['secondaryColorName'],
        baseColorName = json['baseColorName'],
        letter = json['letter'],
        //Change to TextStyle and add Method to parse
        letterStyle = json['letterStyle'] ?? "defaultTagLetterStyle",
        petPageBackgroundColor = HexColor(json['appBackgroundColorHex']),
        primaryColor = HexColor(json['appPetTagPrimaryColor']),
        secondaryColor = HexColor(json['appPetTagSecundaryColor']);
}

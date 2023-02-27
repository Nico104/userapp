import 'package:userapp/pets/profile_details/models/m_tag_personalisation.dart';

class CollarTag {
  final String collarTagId;
  final int petProfileId;
  //!Change with User Model
  final String assignedUseremail;
  final String activationCode;
  final CollarTagPersonalisation collarTagPersonalisation;

  CollarTag(
    this.collarTagId,
    this.petProfileId,
    this.assignedUseremail,
    this.activationCode,
    this.collarTagPersonalisation,
  );

  CollarTag.fromJson(Map<String, dynamic> json)
      : collarTagId = json['collarTag_id'],
        petProfileId = json['petProfile_id'],
        assignedUseremail = json['assignedUseremail'],
        activationCode = json['activationCode'],
        collarTagPersonalisation =
            CollarTagPersonalisation.fromJson(json['CollarTagPersonalisation']);
}

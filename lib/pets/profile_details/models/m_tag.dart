import 'package:userapp/pets/profile_details/models/m_tag_personalisation.dart';

class Tag {
  final String collarTagId;
  final int? petProfileId;
  //!Change with User Model
  final String? assignedUseremail;
  final String activationCode;
  final TagPersonalisation collarTagPersonalisation;

  Tag(
    this.collarTagId,
    this.petProfileId,
    this.assignedUseremail,
    this.activationCode,
    this.collarTagPersonalisation,
  );

  Tag.fromJson(Map<String, dynamic> json)
      : collarTagId = json['collarTag_id'],
        petProfileId = json['petProfile_id'],
        assignedUseremail = json['assignedUseremail'],
        activationCode = json['activationCode'],
        collarTagPersonalisation =
            TagPersonalisation.fromJson(json['CollarTagPersonalisation']);
}

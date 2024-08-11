import 'package:userapp/feature/pets/profile_details/models/m_tag_model.dart';

class Tag {
  final String collarTagId;
  final int? petProfileId;
  //!Change with User Model
  final String? assignedUseremail;
  final String publicCode;
  // final String picturePath;
  final TagModel model;
  // final TagPersonalisation collarTagPersonalisation;

  Tag(
    this.collarTagId,
    this.petProfileId,
    this.assignedUseremail,
    this.publicCode,
    this.model,
    // this.collarTagPersonalisation,
  );

  Tag.fromJson(Map<String, dynamic> json)
      : collarTagId = json['collarTag_id'],
        petProfileId = json['petProfile_id'],
        assignedUseremail = json['assignedUseremail'],
        // picturePath = json['picturePath'],
        publicCode = json['publicCode'],
        model = TagModel.fromJson(json['model']);
  // collarTagPersonalisation =
  //     TagPersonalisation.fromJson(json['CollarTagPersonalisation']);
}

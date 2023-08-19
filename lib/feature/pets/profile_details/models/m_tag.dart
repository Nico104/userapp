class Tag {
  final String collarTagId;
  final int? petProfileId;
  //!Change with User Model
  final String? assignedUseremail;
  final String activationCode;
  final String picturePath;
  // final TagPersonalisation collarTagPersonalisation;

  Tag(
    this.collarTagId,
    this.petProfileId,
    this.assignedUseremail,
    this.activationCode,
    this.picturePath,
    // this.collarTagPersonalisation,
  );

  Tag.fromJson(Map<String, dynamic> json)
      : collarTagId = json['collarTag_id'],
        petProfileId = json['petProfile_id'],
        assignedUseremail = json['assignedUseremail'],
        picturePath = json['picturePath'],
        activationCode = json['activationCode'];
  // collarTagPersonalisation =
  //     TagPersonalisation.fromJson(json['CollarTagPersonalisation']);
}

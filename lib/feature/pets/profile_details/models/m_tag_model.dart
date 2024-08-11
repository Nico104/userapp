class TagModel {
  final int tagModel;
  final String tagModel_shortName;
  final String tagModel_Description;
  final String tagModel_Label;
  final String picturePath;

  TagModel(
    this.tagModel,
    this.tagModel_shortName,
    this.tagModel_Description,
    this.tagModel_Label,
    this.picturePath,
  );

  TagModel.fromJson(Map<String, dynamic> json)
      : tagModel = json['tagModel'],
        tagModel_shortName = json['tagModel_shortName'],
        tagModel_Description = json['tagModel_Description'],
        tagModel_Label = json['tagModel_Label'],
        picturePath = json['picturePath'];
}

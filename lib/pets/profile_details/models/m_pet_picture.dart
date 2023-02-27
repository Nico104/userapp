class PetPicture {
  final int petPictureId;
  final int petProfileId;
  final String petPictureLink;
  final int priority;

  PetPicture(
    this.petPictureId,
    this.petProfileId,
    this.petPictureLink,
    this.priority,
  );

  PetPicture.fromJson(Map<String, dynamic> json)
      : petPictureId = json['pet_picture_id'],
        petProfileId = json['petProfile_id'],
        petPictureLink = json['pet_picture_link'],
        priority = json['pet_picture_priority'];
}

class SocialMedia {
  final int id;
  final String name;
  final String imagepath;
  final String hintText;

  SocialMedia(
    this.id,
    this.name,
    this.imagepath,
    this.hintText,
  );

  SocialMedia.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imagepath = json['imagepath'],
        hintText = json['hintText'];
}

class SocialMediaConnection {
  final int social_media_Id;
  final int contact_id;
  String social_media_account_name;

  SocialMediaConnection(
    this.social_media_Id,
    this.contact_id,
    this.social_media_account_name,
  );

  SocialMediaConnection.fromJson(Map<String, dynamic> json)
      : social_media_Id = json['social_media_Id'],
        contact_id = json['contact_id'],
        social_media_account_name = json['social_media_account_name'];

  Map<String, dynamic> toJson() => {
        'socialmedia_id': social_media_Id,
        'contactId': contact_id,
        'accountName': social_media_account_name,
      };
}

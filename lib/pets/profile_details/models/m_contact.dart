import 'package:userapp/pets/profile_details/models/m_contact_descripton.dart';
import 'm_phone_number.dart';

class Contact {
  final int contactId;
  final int petProfileId;
  final DateTime contactCreationDateTime;
  String contactName;
  String? contactPictureLink;
  ContactDescription? contactDescription;
  String? contactEmail;
  String? contactAddress;
  String? contactFacebook;
  String? contactInstagram;
  List<PhoneNumber> contactTelephoneNumbers;

  Contact(
    this.contactId,
    this.petProfileId,
    this.contactCreationDateTime,
    this.contactName,
    this.contactPictureLink,
    this.contactDescription,
    this.contactEmail,
    this.contactAddress,
    this.contactFacebook,
    this.contactInstagram,
    this.contactTelephoneNumbers,
  );

  Contact.fromJson(Map<String, dynamic> json)
      : contactId = json['contact_id'],
        petProfileId = json['petProfile_id'],
        contactCreationDateTime =
            DateTime.parse(json['contact_creation_DateTime']),
        contactName = json['contact_name'],
        contactPictureLink = json['contact_picture_link'],
        contactDescription = json['contact_description'] != null
            ? ContactDescription.fromJson(json['contact_description'])
            : null,
        contactEmail = json['contact_email'],
        contactAddress = json['contact_address'],
        contactFacebook = json['contact_facebook'],
        contactInstagram = json['contact_instagram'],
        contactTelephoneNumbers = json['contact_telephone_numbers'] != null
            ? (json['contact_telephone_numbers'] as List)
                .map((t) => PhoneNumber.fromJson(t))
                .toList()
            : [];

  Map<String, dynamic> toJson() => {
        'contact_id': contactId,
        'petProfile_id': petProfileId,
        'contact_name': contactName,
        'contact_description': contactDescription,
        'contact_email': contactEmail,
        'contact_address': contactAddress,
        'contact_facebook': contactFacebook,
        'contact_instagram': contactInstagram,
      };
}

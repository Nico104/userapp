import 'm_description.dart';
import 'm_document.dart';
import 'm_important_information.dart';
import 'm_pet_picture.dart';
import 'm_phone_number.dart';
import 'm_scan.dart';
import 'm_tag.dart';

enum Gender { male, female }

class PetProfileDetails {
  final int profileId;
  final DateTime profileCreationDateTime;
  final String petName;
  final Gender petGender;
  final String? petChipId;
  final List<Description> petDescription;
  final List<ImportantInformation> petImportantInformation;
  final String? petOwnerName;
  final List<PhoneNumber> petOwnerTelephoneNumbers;
  final String? petOwnerEmail;
  final String? petOwnerLivingPlace;
  final String? petOwnerFacebook;
  final String? petOwnerInstagram;
  final List<Document> petDocuments;
  final List<PetPicture> petPictures;
  final bool petIsLost;
  final List<Scan> petProfileScans;
  final List<CollarTag> tag;

  PetProfileDetails(
    this.profileId,
    this.profileCreationDateTime,
    this.petName,
    this.petGender,
    this.petChipId,
    this.petOwnerName,
    this.petOwnerEmail,
    this.petOwnerLivingPlace,
    this.petOwnerFacebook,
    this.petOwnerInstagram,
    this.petIsLost,
    this.petDescription,
    this.petImportantInformation,
    this.petOwnerTelephoneNumbers,
    this.petDocuments,
    this.petPictures,
    this.petProfileScans,
    this.tag,
  );

  PetProfileDetails.fromJson(Map<String, dynamic> json)
      : profileId = json['profile_id'],
        profileCreationDateTime =
            DateTime.parse(json['profile_creation_DateTime']),
        petName = json['pet_name'],
        petGender = parseGender(json['pet_gender']),
        petChipId = json['pet_chip_id'],
        petOwnerName = json['pet_owner_name'],
        petOwnerEmail = json['pet_owner_email'],
        petOwnerLivingPlace = json['pet_owner_living_place'],
        petOwnerFacebook = json['pet_owner_facebook'],
        petOwnerInstagram = json['pet_owner_instagram'],
        petIsLost = json['pet_is_Lost'],
        petDescription = (json['pet_description'] as List)
            .map((t) => Description.fromJson(t))
            .toList(),
        petImportantInformation = (json['pet_important_information'] as List)
            .map((t) => ImportantInformation.fromJson(t))
            .toList(),
        petOwnerTelephoneNumbers = (json['pet_owner_telephone_numbers'] as List)
            .map((t) => PhoneNumber.fromJson(t))
            .toList(),
        petDocuments = (json['pet_documents'] as List)
            .map((t) => Document.fromJson(t))
            .toList(),
        petPictures = (json['pet_pictures'] as List)
            .map((t) => PetPicture.fromJson(t))
            .toList(),
        petProfileScans = (json['pet_profile_scans'] as List)
            .map((t) => Scan.fromJson(t))
            .toList(),
        tag = (json['Tag'] as List).map((t) => CollarTag.fromJson(t)).toList();

  // Map<String, dynamic> toJson() => {
  //       'name': text,
  //       'email': languageCode,
  //     };
}

Gender parseGender(String value) {
  if (value.toUpperCase() == "MALE") {
    return Gender.male;
  } else {
    return Gender.female;
  }
}

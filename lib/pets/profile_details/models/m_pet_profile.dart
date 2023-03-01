import 'm_description.dart';
import 'm_document.dart';
import 'm_important_information.dart';
import 'm_pet_picture.dart';
import 'm_phone_number.dart';
import 'm_scan.dart';
import 'm_tag.dart';

enum Gender { male, female }

class PetProfileDetails {
  final int? profileId;
  final DateTime? profileCreationDateTime;
  String? petName;
  Gender? petGender;
  String? petChipId;
  List<Description> petDescription;
  List<ImportantInformation> petImportantInformation;
  String? petOwnerName;
  List<PhoneNumber> petOwnerTelephoneNumbers;
  String? petOwnerEmail;
  String? petOwnerLivingPlace;
  String? petOwnerFacebook;
  String? petOwnerInstagram;
  List<Document> petDocuments;
  List<PetPicture> petPictures;
  bool petIsLost;
  List<Tag> tag;
  final List<Scan> petProfileScans;

  PetProfileDetails clone() => PetProfileDetails(
        profileId,
        profileCreationDateTime,
        petName,
        petGender,
        petChipId,
        petOwnerName,
        petOwnerEmail,
        petOwnerLivingPlace,
        petOwnerFacebook,
        petOwnerInstagram,
        petIsLost,
        petDescription.map((element) => element.clone()).toList(),
        List.from(petImportantInformation),
        List.from(petOwnerTelephoneNumbers),
        List.from(petDocuments),
        List.from(petPictures),
        List.from(petProfileScans),
        List.from(tag),
      );

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
        petGender = parseGenderFromString(json['pet_gender']),
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
        tag = (json['Tag'] as List).map((t) => Tag.fromJson(t)).toList();

  //New PetProfileDetails Object for creatring new Profile
  PetProfileDetails.createNewEmptyProfile(this.tag)
      : profileId = null,
        profileCreationDateTime = null,
        petName = null,
        petGender = Gender.male,
        petChipId = null,
        petOwnerName = null,
        petOwnerEmail = null,
        petOwnerLivingPlace = null,
        petOwnerFacebook = null,
        petOwnerInstagram = null,
        petIsLost = false,
        petDescription = List<Description>.empty(growable: true),
        petImportantInformation =
            List<ImportantInformation>.empty(growable: true),
        petOwnerTelephoneNumbers = List<PhoneNumber>.empty(growable: true),
        petDocuments = List<Document>.empty(growable: true),
        petPictures = List<PetPicture>.empty(growable: true),
        petProfileScans = List<Scan>.empty(growable: false);

  Map<String, dynamic> toJson() => {
        'pet_name': petName,
        'pet_gender':
            petGender != null ? parseStringFromGender(petGender!) : petGender,
        'pet_chip_id': petChipId,
        'pet_owner_name': petOwnerName,
        'pet_owner_email': petOwnerEmail,
        'pet_owner_living_place': petOwnerLivingPlace,
        'pet_owner_facebook': petOwnerFacebook,
        'pet_owner_instagram': petOwnerInstagram,
        'pet_is_Lost': petIsLost
      };
}

Gender parseGenderFromString(String value) {
  if (value.toUpperCase() == "MALE") {
    return Gender.male;
  } else {
    return Gender.female;
  }
}

String parseStringFromGender(Gender value) {
  if (value == Gender.male) {
    return "MALE";
  } else {
    return "FEMALE";
  }
}

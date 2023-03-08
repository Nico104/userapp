import '../../../language/m_language.dart';

class PhoneNumber {
  final int? petProfileId;
  String phoneNumber;
  int priority;
  Language language;

  PhoneNumber(
    this.petProfileId,
    this.phoneNumber,
    this.priority,
    this.language,
  );

  PhoneNumber clone() => PhoneNumber(
        petProfileId,
        phoneNumber,
        priority,
        language,
      );

  PhoneNumber.fromJson(Map<String, dynamic> json)
      : petProfileId = json['petProfile_id'],
        phoneNumber = json['phone_number'],
        priority = json['phone_number_priority'],
        language = Language.fromJson(json['phone_number_Language']);
}

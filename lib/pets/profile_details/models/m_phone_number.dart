import '../../../language/m_language.dart';

class PhoneNumber {
  final int phoneNumberId;
  final int petProfileId;
  String phoneNumber;
  int priority;
  Language language;

  PhoneNumber(
    this.phoneNumberId,
    this.petProfileId,
    this.phoneNumber,
    this.priority,
    this.language,
  );

  PhoneNumber clone() => PhoneNumber(
        phoneNumberId,
        petProfileId,
        phoneNumber,
        priority,
        language,
      );

  PhoneNumber.fromJson(Map<String, dynamic> json)
      : phoneNumberId = json['phone_number_id'],
        petProfileId = json['petProfile_id'],
        phoneNumber = json['phone_number'],
        priority = json['phone_number_priority'],
        language = Language.fromJson(json['phone_number_Language']);

  Map<String, dynamic> toJson(int? petProfileId) => {
        'petProfile_id': petProfileId,
        'language_key': language.languageKey,
        'phone_number': phoneNumber,
        'phone_number_id': phoneNumberId,
        'phone_number_priority': priority,
      };
}

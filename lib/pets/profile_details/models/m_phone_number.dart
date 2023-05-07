import '../../../language/m_language.dart';

class PhoneNumber {
  final int phoneNumberId;
  final int petProfileId;
  String phoneNumber;
  int priority;
  Country country;

  PhoneNumber(
    this.phoneNumberId,
    this.petProfileId,
    this.phoneNumber,
    this.priority,
    this.country,
  );

  PhoneNumber clone() => PhoneNumber(
        phoneNumberId,
        petProfileId,
        phoneNumber,
        priority,
        country,
      );

  PhoneNumber.fromJson(Map<String, dynamic> json)
      : phoneNumberId = json['phone_number_id'],
        petProfileId = json['petProfile_id'],
        phoneNumber = json['phone_number'],
        priority = json['phone_number_priority'],
        country = Country.fromJson(json['Country']);

  Map<String, dynamic> toJson() => {
        'petProfile_id': petProfileId,
        'country_key': country.countryKey,
        'phone_number': phoneNumber,
        'phone_number_id': phoneNumberId,
        'phone_number_priority': priority,
      };
}

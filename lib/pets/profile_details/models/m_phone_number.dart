import '../../../language/m_language.dart';

class PhoneNumber {
  final int phoneNumberId;
  final int contactId;
  String phoneNumber;
  int priority;
  Country country;

  PhoneNumber(
    this.phoneNumberId,
    this.contactId,
    this.phoneNumber,
    this.priority,
    this.country,
  );

  PhoneNumber clone() => PhoneNumber(
        phoneNumberId,
        contactId,
        phoneNumber,
        priority,
        country,
      );

  PhoneNumber.fromJson(Map<String, dynamic> json)
      : phoneNumberId = json['phone_number_id'],
        contactId = json['contactContact_id'],
        phoneNumber = json['phone_number'],
        priority = json['phone_number_priority'],
        country = Country.fromJson(json['Country']);

  Map<String, dynamic> toJson() => {
        'contactContact_id': contactId,
        'country_key': country.countryKey,
        'phone_number': phoneNumber,
        'phone_number_id': phoneNumberId,
        'phone_number_priority': priority,
      };
}

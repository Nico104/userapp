class PhoneNumber {
  final int petProfileId;
  final String phoneNumber;
  final int priority;

  PhoneNumber(
    this.petProfileId,
    this.phoneNumber,
    this.priority,
  );

  PhoneNumber.fromJson(Map<String, dynamic> json)
      : petProfileId = json['petProfile_id'],
        phoneNumber = json['phone_number'],
        priority = json['phone_number_priority'];
}

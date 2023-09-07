class BehaviourInformation {
  final int behaviourInformationId;
  final int petProfileId;
  bool? goodWithKids;
  bool? goodWithCats;
  bool? goodWithDogs;
  bool? goodWithCars;
  bool? goodWithStrangers;

  BehaviourInformation(
    this.behaviourInformationId,
    this.petProfileId,
  );

  BehaviourInformation.fromJson(Map<String, dynamic> json)
      : behaviourInformationId = json['behaviour_information_id'],
        petProfileId = json['petProfile_id'],
        goodWithKids = json['good_with_kids'],
        goodWithCats = json['good_with_cats'],
        goodWithDogs = json['good_with_dogs'],
        goodWithCars = json['good_with_cars'],
        goodWithStrangers = json['good_with_strangers'];

  Map<String, dynamic> toJson() => {
        'behaviour_information_id': behaviourInformationId,
        'petProfile_id': petProfileId,
        'good_with_kids': goodWithKids,
        'good_with_cats': goodWithCats,
        'good_with_dogs': goodWithDogs,
        'good_with_cars': goodWithCars,
        'good_with_strangers': goodWithStrangers,
      };
}

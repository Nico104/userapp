// class ImportantInformation {
//   final int importantInformationId;
//   String text;
//   // Language language;
//   final int petProfileId;

//   ImportantInformation(
//       this.importantInformationId, this.text, this.petProfileId);

//   // ImportantInformation clone() => ImportantInformation(text, petProfileId);

//   ImportantInformation.fromJson(Map<String, dynamic> json)
//       : text = json['important_information_text'],
//         importantInformationId = json['important_information_id'],
//         petProfileId = json['petProfile_id'];
//   // language = Language.fromJson(json['important_information_language']);

//   Map<String, dynamic> toJson() => {
//         'petProfile_id': petProfileId,
//         // 'language_key': language.languageKey,
//         'important_information_text': text,
//         'important_information_id': importantInformationId,
//       };
// }

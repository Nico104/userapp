import 'package:userapp/language/m_language.dart';

class ImportantInformation {
  String text;
  Language language;
  final int petProfileId;

  ImportantInformation(this.text, this.language, this.petProfileId);

  ImportantInformation clone() =>
      ImportantInformation(text, language, petProfileId);

  ImportantInformation.fromJson(Map<String, dynamic> json)
      : text = json['important_information_text'],
        petProfileId = json['petProfile_id'],
        language = Language.fromJson(json['important_information_language']);

  Map<String, dynamic> toJson() => {
        'petProfile_id': petProfileId,
        'language_key': language.languageKey,
        'important_information_text': text
      };
}

List<String> isolateLanguageCodesFromImportantInformation(
    List<ImportantInformation> importantInformations) {
  List<String> languageCodes = List<String>.empty(growable: true);
  for (ImportantInformation importantInformation in importantInformations) {
    languageCodes.add(importantInformation.language.languageKey);
  }
  return languageCodes;
}

List<Language> isolateLanguagesFromImportantInformation(
    List<ImportantInformation> importantInformation) {
  List<Language> languages = List<Language>.empty(growable: true);
  for (ImportantInformation info in importantInformation) {
    languages.add(info.language);
  }
  return languages;
}

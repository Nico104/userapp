import 'package:userapp/language/m_language.dart';

class ImportantInformation {
  String text;
  Language language;

  ImportantInformation(this.text, this.language);

  ImportantInformation clone() => ImportantInformation(
        text,
        language,
      );

  ImportantInformation.fromJson(Map<String, dynamic> json)
      : text = json['important_information_text'],
        language = Language.fromJson(json['important_information_language']);

  Map<String, dynamic> toJson(int petProfileId) => {
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

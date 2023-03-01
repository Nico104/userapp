import 'package:userapp/language/m_language.dart';

class ImportantInformation {
  final String text;
  final Language language;

  ImportantInformation(this.text, this.language);

  ImportantInformation clone() => ImportantInformation(
        text,
        language,
      );

  ImportantInformation.fromJson(Map<String, dynamic> json)
      : text = json['important_information_text'],
        language = Language.fromJson(json['important_information_language']);

  // Map<String, dynamic> toJson() => {
  //       'name': text,
  //       'email': languageCode,
  //     };
}

List<String> isolateLanguageCodesFromImportantInformation(
    List<ImportantInformation> importantInformations) {
  List<String> languageCodes = List<String>.empty(growable: true);
  for (ImportantInformation importantInformation in importantInformations) {
    languageCodes.add(importantInformation.language.languageKey);
  }
  return languageCodes;
}

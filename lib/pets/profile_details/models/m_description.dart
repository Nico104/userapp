import 'package:userapp/language/m_language.dart';

class Description {
  final int petProfileId;
  String text;
  Language language;

  Description(
    this.text,
    this.language,
    this.petProfileId,
  );

  Description clone() => Description(
        text,
        language,
        petProfileId,
      );

  Description.fromJson(Map<String, dynamic> json)
      : text = json['description_text'],
        petProfileId = json['petProfile_id'],
        language = Language.fromJson(json['description_language']);

  Map<String, dynamic> toJson() => {
        'petProfile_id': petProfileId,
        'language_key': language.languageKey,
        'description_text': text
      };
}

List<String> isolateLanguageCodesFromDescription(
    List<Description> descriptions) {
  List<String> languageCodes = List<String>.empty(growable: true);
  for (Description description in descriptions) {
    languageCodes.add(description.language.languageKey);
  }
  return languageCodes;
}

List<Language> isolateLanguagesFromDescription(List<Description> descriptions) {
  List<Language> languages = List<Language>.empty(growable: true);
  for (Description description in descriptions) {
    languages.add(description.language);
  }
  return languages;
}

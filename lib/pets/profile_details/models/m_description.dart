import 'package:userapp/language/m_language.dart';

class Description {
  String text;
  Language language;

  Description(this.text, this.language);

  Description clone() => Description(
        text,
        language,
      );

  Description.fromJson(Map<String, dynamic> json)
      : text = json['description_text'],
        language = Language.fromJson(json['description_language']);

  Map<String, dynamic> toJson(int petProfileId) => {
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

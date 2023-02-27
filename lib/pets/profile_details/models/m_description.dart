import 'package:userapp/language/m_language.dart';

class Description {
  final String text;
  final Language language;

  Description(this.text, this.language);

  Description.fromJson(Map<String, dynamic> json)
      : text = json['description_text'],
        language = Language.fromJson(json['description_language']);

  // Map<String, dynamic> toJson() => {
  //       'name': text,
  //       'email': languageCode,
  //     };
}

List<String> isolateLanguageCodesFromDescription(
    List<Description> descriptions) {
  List<String> languageCodes = List<String>.empty(growable: true);
  for (Description description in descriptions) {
    languageCodes.add(description.language.languageKey);
  }
  return languageCodes;
}

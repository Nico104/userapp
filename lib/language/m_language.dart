class Language {
  final String languageLabel;
  final String languageImagePath;
  final String languageKey;
  final String langaugeCountry;
  final String languagePrefix;
  final bool languageIsAvailableForAppTranslation;

  Language(
    this.languageLabel,
    this.languageImagePath,
    this.languageKey,
    this.langaugeCountry,
    this.languagePrefix,
    this.languageIsAvailableForAppTranslation,
  );

  Language.fromJson(Map<String, dynamic> json)
      : languageLabel = json['language_label'],
        languageImagePath = json['language_image_path'],
        languageKey = json['language_key'],
        langaugeCountry = json['language_country'],
        languagePrefix = json['language_country_prefix'],
        languageIsAvailableForAppTranslation =
            json['language_isAvailableForAppTranslation'];

  // Map<String, dynamic> toJson() => {
  //       'name': text,
  //       'email': languageCode,
  //     };
}

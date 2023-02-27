class Language {
  final String languageLabel;
  final String languageImagePath;
  final String languageKey;

  Language(this.languageLabel, this.languageKey, this.languageImagePath);

  Language.fromJson(Map<String, dynamic> json)
      : languageLabel = json['language_label'],
        languageImagePath = json['language_image_path'],
        languageKey = json['language_key'];

  // Map<String, dynamic> toJson() => {
  //       'name': text,
  //       'email': languageCode,
  //     };
}

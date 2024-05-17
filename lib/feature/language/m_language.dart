import 'dart:ui';

import 'package:userapp/feature/pets/profile_details/g_profile_detail_globals.dart';

class Language {
  final String languageLabel;
  final String languageImagePath;
  final String languageKey;
  // final String langaugeCountry;
  // final String languagePrefix;
  final bool languageIsAvailableForAppTranslation;

  Language(
    this.languageLabel,
    this.languageImagePath,
    this.languageKey,
    // this.langaugeCountry,
    // this.languagePrefix,
    this.languageIsAvailableForAppTranslation,
  );

  Language.fromJson(Map<String, dynamic> json)
      : languageLabel = json['language_label'],
        languageImagePath = json['langauge_flag_image_path'],
        languageKey = json['language_key'],
        // langaugeCountry = json['language_country'],
        // languagePrefix = json['language_country_prefix'],
        languageIsAvailableForAppTranslation =
            json['language_isAvailableForAppTranslation'];
}

String getDeviceLanguage() {
  return window.locale.languageCode;
}

bool listContainsLanguage(List<Language> list, Language language) {
  for (Language item in list) {
    if (item.languageKey == language.languageKey) {
      return true;
    }
  }
  return false;
}

Language? getLanguageFromKey(String languageKey) {
  for (var element in availableLanguages) {
    if (element.languageKey == languageKey) {
      return element;
    }
  }
  return null;
}

class Country {
  final String countryKey;
  final String countryFlagImagePath;
  final String countryPhonePrefix;
  final Language language;

  Country(
    this.countryKey,
    this.countryFlagImagePath,
    this.countryPhonePrefix,
    this.language,
  );

  Country.fromJson(Map<String, dynamic> json)
      : countryKey = json['country_key'],
        countryFlagImagePath = json['country_flag_image_path'],
        countryPhonePrefix = json['country_phone_prefix'],
        language = Language.fromJson(json['country_language']);
}

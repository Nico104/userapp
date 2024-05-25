import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/contact/u_contact.dart';

import '../../g_profile_detail_globals.dart';
import 'add_language_button.dart';

class NoLanguages extends StatelessWidget {
  const NoLanguages(
      {super.key, required this.contactId, required this.reloadContact});

  final int contactId;
  final VoidCallback reloadContact;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              "noLanguagesWidget_includingSpokenLanguagesHelps".tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const SizedBox(width: 16),
          AddSpokenLanguageButton(
            addLangauge: (language) {
              connectLanguageSpoken(contactId, language.languageKey)
                  .then((value) => reloadContact());
            },
            title: "noLanguagesWidget_addSpokenLanguage".tr(),
            availableLanguages: availableLanguages,
            unavailableLanguages: const [],
          ),
        ],
      ),
    );
  }
}

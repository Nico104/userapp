import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/contact/u_contact.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

import '../../../../language/language_selector.dart';
import '../../../../language/m_language.dart';
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
              "Including a contact's spoken languages helps those who find your lost pet contact you more easily.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const SizedBox(width: 16),
          AddSpokenLanguageButton(
            addLangauge: (language) {
              connectLanguageSpoken(contactId, language.languageKey)
                  .then((value) => reloadContact());
            },
            title: "Add Spoken Language",
            availableLanguages: availableLanguages,
            unavailableLanguages: [],
          ),
        ],
      ),
    );
  }
}

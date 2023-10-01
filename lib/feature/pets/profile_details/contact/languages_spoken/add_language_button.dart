import 'package:flutter/material.dart';
import '../../../../../general/utils_theme/custom_colors.dart';
import '../../../../language/language_selector.dart';
import '../../../../language/m_language.dart';

class AddSpokenLanguageButton extends StatelessWidget {
  const AddSpokenLanguageButton(
      {super.key,
      required this.unavailableLanguages,
      required this.availableLanguages,
      required this.title,
      required this.addLangauge});

  final List<Language> unavailableLanguages;
  final List<Language> availableLanguages;
  final String title;
  final Function(Language) addLangauge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LanguageSelector(
              unavailableLanguages: unavailableLanguages,
              availableLanguages: availableLanguages,
              title: title,
            ),
          ),
        ).then((value) {
          if (value is Language) {
            addLangauge(value);
          }
        });
      },
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(
                width: 0.4,
                color:
                    getCustomColors(context).lightBorder ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add,
              size: 22,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

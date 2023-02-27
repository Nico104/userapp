import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'm_language.dart';

class LanguagePickerDialogComponent extends StatelessWidget {
  LanguagePickerDialogComponent({
    super.key,
    required this.excludeLanguageCodes,
  });

  final List<String> excludeLanguageCodes;

  //FutureBuilder then to get from Server
  final List<Language> avaliableLanguages = [
    Language("English", "en", "https://picsum.photos/100")
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0)),
      child: Container(
        width: 60.w,
        // height: 60.h,
        constraints: BoxConstraints(maxHeight: 60.h),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Language"),
              const SizedBox(height: 28),
              ListView.builder(
                itemCount: avaliableLanguages.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (excludeLanguageCodes.contains(
                              avaliableLanguages.elementAt(index).languageKey))
                          ? UnavailableLanguage(
                              language: avaliableLanguages.elementAt(index))
                          : AvailableLanguage(
                              language: avaliableLanguages.elementAt(index)),
                      (index != avaliableLanguages.length - 1)
                          ? const Divider()
                          : const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvailableLanguage extends StatelessWidget {
  const AvailableLanguage({
    super.key,
    required this.language,
  });

  final Language language;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, language),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(language.languageImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              Text(language.languageLabel),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class UnavailableLanguage extends StatelessWidget {
  const UnavailableLanguage({
    super.key,
    required this.language,
  });

  final Language language;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Opacity(
          opacity: 0.5,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(language.languageImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              Text(language.languageLabel),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

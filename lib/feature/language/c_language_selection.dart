import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/g_profile_detail_globals.dart';
import 'm_language.dart';

//? id this file even needed?
class LanguagePickerDialogComponent extends StatelessWidget {
  const LanguagePickerDialogComponent({
    super.key,
    required this.excludeLanguages,
  });

  final List<Language> excludeLanguages;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 70.w,
        constraints: BoxConstraints(maxHeight: 60.h),
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "selectLanguageTitle".tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              ListView.builder(
                itemCount: availableLanguages.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AvailableLanguage(
                        language: availableLanguages.elementAt(index),
                        isActive: !listContainsLanguage(excludeLanguages,
                            availableLanguages.elementAt(index)),
                      ),
                      (index != availableLanguages.length - 1)
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
    required this.isActive,
  });

  final Language language;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isActive) {
          Navigator.pop(context, language);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Opacity(
            opacity: isActive ? 1 : 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/60"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 42),
                Text(language.languageLabel),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/language/c_language_selection.dart';
import '../theme/custom_colors.dart';
import '../theme/custom_text_styles.dart';
import 'm_language.dart';

class TranslationPicker extends StatelessWidget {
  const TranslationPicker({
    super.key,
    required this.availableTranslations,
    required this.currentTranslation,
  });

  final List<Language> availableTranslations;
  final Language currentTranslation;

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
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Translation",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              ListView.builder(
                itemCount: availableTranslations.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AvailableTranslation(
                        language: availableTranslations.elementAt(index),
                        isActive: !(currentTranslation.languageKey ==
                            availableTranslations.elementAt(index).languageKey),
                      ),
                      (index != availableTranslations.length - 1)
                          ? const Divider()
                          : const SizedBox(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 28),
              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => LanguagePickerDialogComponent(
                      excludeLanguages: availableTranslations,
                    ),
                  ).then((value) {
                    //if null just pop and dismiss all dialogs, if Language return Language
                    Navigator.pop(context, value);
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  backgroundColor: getCustomColors(context).accent,
                  side: BorderSide(
                    width: 0.5,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "New Translation",
                  style: getCustomTextStyles(context)
                      .dataEditDialogButtonSaveStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvailableTranslation extends StatelessWidget {
  const AvailableTranslation({
    super.key,
    required this.language,
    required this.isActive,
  });

  final Language language;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isActive) {
          Navigator.pop(context, language);
        }
      },
      child: Opacity(
        opacity: isActive ? 1 : 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Row(
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

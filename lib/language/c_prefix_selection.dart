import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/g_profile_detail_globals.dart';

import '../styles/text_styles.dart';
import 'm_language.dart';

class PrefixPickerDialogComponent extends StatelessWidget {
  const PrefixPickerDialogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: 70.w,
        // height: 60.h,
        constraints: BoxConstraints(maxHeight: 60.h),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Prefix",
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
                      SinglePrefix(
                          language: availableLanguages.elementAt(index)),
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

class SinglePrefix extends StatelessWidget {
  const SinglePrefix({
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
              SizedBox(width: 36),
              Text(language.languageLabel),
              Text("+(${language.languagePrefix})"),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:userapp/general/widgets/loading_indicator.dart';

import '../../general/network_globals.dart';
import '../../general/widgets/custom_scroll_view.dart';
import 'm_language.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector(
      {super.key,
      required this.unavailableLanguages,
      required this.availableLanguages,
      required this.title,
      this.activeLanguage,
      this.heroTag});

  final List<Language> unavailableLanguages;
  final List<Language> availableLanguages;
  final Language? activeLanguage;
  final String title;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomNicoScrollView(
        title: Text(title),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 28),
              activeLanguage != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Hero(
                            tag: activeLanguage!.languageKey,
                            child: SingleLanguage(language: activeLanguage!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 0.5,
                            height: 0,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              ListView.builder(
                itemCount: availableLanguages.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  bool isActive = false;
                  if (activeLanguage != null) {
                    if (activeLanguage?.languageKey ==
                            availableLanguages.elementAt(index).languageKey ||
                        listContainsLanguage(unavailableLanguages,
                            availableLanguages.elementAt(index))) {
                      isActive = true;
                    }
                  }
                  return Opacity(
                    opacity: isActive ? 0.3 : 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                          isActive ? null : availableLanguages.elementAt(index),
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: SingleLanguage(
                          language: availableLanguages.elementAt(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        onScroll: () {},
      ),
    );
  }
}

class SingleLanguage extends StatelessWidget {
  const SingleLanguage({super.key, required this.language});

  final Language language;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 40,
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: s3BaseUrl + language.languageImagePath,
                placeholder: (context, url) => const CustomLoadingIndicatior(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        //Put countrykey as a translation element
        Text(
          language.languageLabel,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const Spacer(),
      ],
    );
  }
}

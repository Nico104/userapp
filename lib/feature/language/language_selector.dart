import 'package:flutter/material.dart';

import '../../general/network_globals.dart';
import 'm_language.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector(
      {super.key,
      required this.unavailableLanguages,
      required this.availableLanguages,
      required this.title});

  final List<Language> unavailableLanguages;
  final List<Language> availableLanguages;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: availableLanguages.length,
        itemBuilder: (context, index) {
          bool available = !listContainsLanguage(
            unavailableLanguages,
            availableLanguages.elementAt(index),
          );
          return Padding(
            padding: const EdgeInsets.all(22),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: Opacity(
                opacity: available ? 1 : 0.34,
                child: IgnorePointer(
                  ignoring: !available,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                        availableLanguages.elementAt(index),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 3 / 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  s3BaseUrl +
                                      availableLanguages
                                          .elementAt(index)
                                          .languageImagePath,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                availableLanguages
                                    .elementAt(index)
                                    .languageLabel,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

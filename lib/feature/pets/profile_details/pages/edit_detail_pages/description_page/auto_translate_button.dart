import 'package:flutter/material.dart';

import '../../../../../language/m_language.dart';
import '../../../models/m_description.dart';
import 'auto_translate_dialog.dart';

class AutoTranslateButton extends StatelessWidget {
  const AutoTranslateButton({
    super.key,
    required this.descriptions,
    required this.targetLanguage,
    required this.returnTranslation,
  });

  final List<Description> descriptions;
  final Language targetLanguage;
  final Function(String) returnTranslation;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AutoTranslateDialog(
            descriptions: descriptions,
            targetLanguage: targetLanguage,
          ),
        ).then((value) {
          if (value is String) {
            returnTranslation(value);
          }
        });
      },
      icon: const Icon(Icons.translate),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../styles/text_styles.dart';
import 'g_profile_detail_globals.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 16, bottom: 16, left: profileDetailLeftPadding),
      child: Text(
        text,
        style: profileDetailsSectionTitle,
      ),
    );
  }
}

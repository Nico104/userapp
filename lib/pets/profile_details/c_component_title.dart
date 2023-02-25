import 'package:flutter/material.dart';

import '../../styles/text_styles.dart';

class ComponentTitle extends StatelessWidget {
  const ComponentTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: profileDetailsComponentTitle,
        ),
        const SizedBox(
          height: 28,
        )
      ],
    );
  }
}

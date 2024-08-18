import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Icon8Link extends StatelessWidget {
  const Icon8Link({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Icons by ",
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          onTap: () {
            launchUrl(Uri.parse("https://icons8.com"),
                mode: LaunchMode.externalApplication);
          },
          child: Text(
            "Icons8",
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(decoration: TextDecoration.underline),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

import '../settings/setting_screen.dart';
import '../styles/text_styles.dart';
import '../theme/custom_text_styles.dart';

class MyPetsNavbar extends StatelessWidget {
  const MyPetsNavbar({super.key});

  final String username = "Musta";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 28,
        ),
        Text(
          "Welcome back ",
          style: getCustomTextStyles(context).homeWelcomeMessage,
        ),
        Text(
          username,
          style: getCustomTextStyles(context).homeWelcomeUser,
        ),
        const Spacer(),
        const Icon(
          CustomIcons.notification,
          size: 28,
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Settings(),
              ),
            );
          },
          child: const Icon(
            CustomIcons.setting,
            size: 28,
          ),
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }
}

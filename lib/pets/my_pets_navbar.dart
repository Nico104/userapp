import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

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
        const Text("Welcome back "),
        Text(username),
        const Spacer(),
        const Icon(Icons.notifications_outlined),
        const Icon(CustomIcons.setting),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'g_profile_detail_globals.dart';

class PaddingComponent extends StatelessWidget {
  const PaddingComponent(
      {super.key, required this.component, this.ignoreLeftPadding = false});

  final Widget component;
  final bool ignoreLeftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 28.0, left: ignoreLeftPadding ? 0 : profileDetailLeftPadding),
      child: component,
    );
  }
}

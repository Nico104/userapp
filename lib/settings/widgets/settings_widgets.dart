import 'package:flutter/material.dart';

import '../../styles/text_styles.dart';

const double settingItemSpacing = 16;

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.label,
    required this.leading,
    required this.suffix,
    this.onTap,
    this.suffixText,
  });

  final String label;
  final Widget? leading;
  final Widget? suffix;
  final String? suffixText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            leading ?? const SizedBox(),
            const SizedBox(width: 16),
            Text(
              label,
              style: settingsItem,
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  suffixText ?? "",
                  style: settingsSuffixText,
                ),
                const SizedBox(width: 8),
                suffix ?? const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      margin: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: Colors.black,
          // strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

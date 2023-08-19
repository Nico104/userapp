import 'package:flutter/material.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

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
        margin: const EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: Row(
          children: [
            leading ?? const SizedBox(),
            const SizedBox(width: 16),
            Text(
              label,
              // style: settingsItem,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  suffixText ?? "",
                  style: Theme.of(context).textTheme.labelSmall,
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
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.fromLTRB(28, 16, 28, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(
          width: 0.5,
          color: getCustomColors(context).hardBorder ?? Colors.transparent,
          // strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: kElevationToShadow[3],
      ),
      child: child,
    );
  }
}

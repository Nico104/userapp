import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class VisibilityTab extends StatelessWidget {
  const VisibilityTab({super.key, required this.index, required this.onTap});

  final int index;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: VisibilityTabItem(
            title: "Share",
            active: index == 0,
            index: 0,
            onTap: () => onTap(0),
          ),
        ),
        Expanded(
          child: VisibilityTabItem(
            title: "Scan",
            active: index == 1,
            index: 1,
            onTap: () => onTap(1),
          ),
        )
      ],
    );
  }
}

class VisibilityTabItem extends StatelessWidget {
  const VisibilityTabItem(
      {super.key,
      required this.title,
      required this.active,
      required this.index,
      required this.onTap});

  final String title;
  final bool active;
  final int index;
  final VoidCallback onTap;

  BorderRadiusGeometry getBorderRadius() {
    if (index == 1) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        topLeft: Radius.circular(8),
      );
    } else {
      return const BorderRadius.only(
        bottomRight: Radius.circular(8),
        topRight: Radius.circular(8),
      );
    }
  }

  EdgeInsetsGeometry getMargin() {
    if (index == 1) {
      return EdgeInsets.only(left: 20);
    } else {
      return EdgeInsets.only(right: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: active ? 1 : 0.4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: active ? FontWeight.w600 : FontWeight.w300),
            ),
            const SizedBox(height: 12),
            AnimatedContainer(
              duration: Durations.short2,
              margin: getMargin(),
              width: double.infinity,
              height: 5,
              decoration: BoxDecoration(
                color: active
                    ? getCustomColors(context).accentHighContrast
                    : Colors.transparent,
                borderRadius: getBorderRadius(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

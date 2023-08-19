import 'package:flutter/material.dart';

class SharePageButton extends StatelessWidget {
  const SharePageButton({
    super.key,
    required this.prefix,
    required this.label,
    this.onTap,
  });

  final Widget prefix;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[4],
        ),
        child: Row(
          children: [
            prefix,
            const SizedBox(width: 16),
            Text(label),
          ],
        ),
      ),
    );
  }
}

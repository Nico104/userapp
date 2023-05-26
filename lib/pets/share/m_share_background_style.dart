import 'package:flutter/material.dart';

class ShareBackgroundStyle {
  final String label;
  final BoxDecoration qrBackgroundBoxDecoration;
  final BoxDecoration labelBoxDecoration;
  final TextStyle? labelTextStyle;
  final Color qrCodeColor;
  final TextStyle? nameTextStyle;

  ShareBackgroundStyle(
    this.label,
    this.qrBackgroundBoxDecoration,
    this.labelBoxDecoration,
    this.labelTextStyle,
    this.qrCodeColor,
    this.nameTextStyle,
  );
}

List<ShareBackgroundStyle> getShareBackgroundStyles() {
  return [
    ShareBackgroundStyle(
      "Green",
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade300,
            Colors.green.shade700,
          ],
        ),
      ),
      BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          width: 2,
          color: Colors.black87,
        ),
      ),
      TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.black.withOpacity(0.64),
      ),
      Colors.green.shade800,
      TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        color: Colors.green.shade800,
      ),
    ),
    ShareBackgroundStyle(
      "Purple",
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade300,
            Colors.purple.shade700,
          ],
        ),
      ),
      BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          width: 2,
          color: Colors.black87,
        ),
      ),
      TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.black.withOpacity(0.64),
      ),
      Colors.purple.shade800,
      TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        color: Colors.purple.shade800,
      ),
    ),
  ];
}

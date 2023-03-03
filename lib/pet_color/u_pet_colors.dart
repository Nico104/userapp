import 'package:flutter/material.dart';
import 'pet_colors.dart';

enum TagColor { yellow }

TagColor getTagColorFromString(String color) {
  return TagColor.yellow;
}

Color getBackgroundColorFromTagColor(TagColor tagColor) {
  return petBgYellow;
}

import 'package:flutter/material.dart';

Color getPageBackgroundColorMixture(Color color1, Color color2, double page) {
  double mixFactor = page - page.floor();
  return Color.alphaBlend(color1.withOpacity(1 - mixFactor), color2);
}

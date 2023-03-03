import 'package:flutter/material.dart';
import 'rotation_3d.dart';
import 'dart:math' as math;

class PetProfilePreviewPageTransform extends StatelessWidget {
  const PetProfilePreviewPageTransform({
    super.key,
    required this.page,
    required this.position,
    required this.child,
    required this.maxRotation,
    required this.minScaling,
  });

  final double page;
  final int position;
  final Widget child;

  final double maxRotation;
  final double minScaling;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: getScaling(page, position, minScaling),
      alignment: Alignment(getAlignmentOffset(page, position), 0),
      child: Rotation3d(
        rotationY: getYRotation(page, position, maxRotation),
        child: child,
      ),
    );
  }
}

double getYRotation(double page, int index, double maxRotation) {
  double factor = (page - index);
  double rotation = 0;
  if (factor <= 1 || factor >= -1) {
    rotation = factor * maxRotation;
  }
  return rotation;
}

double getScaling(double page, int index, double minScaling) {
  double factor = (page - index);
  double scaling = 0;
  if (factor <= 1 || factor >= -1) {
    scaling = 1 - math.sqrt(factor * factor) * (1 - minScaling);
  }
  return scaling;
}

double getAlignmentOffset(double page, int index) {
  double factor = (page - index);
  double alignmentOffset = 0;
  if (factor <= 1 || factor >= -1) {
    // scaling = 1 - math.sqrt(factor * factor) * minScaling;
    alignmentOffset = factor;
  }
  return alignmentOffset;
}

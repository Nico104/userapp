import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class CustomLoadingIndicatior extends StatelessWidget {
  const CustomLoadingIndicatior({super.key});

  @override
  Widget build(BuildContext context) {
    // return SpinKitPulse(
    //   color: getCustomColors(context).accent,
    //   duration: const Duration(milliseconds: 250),
    // );
    return SpinKitSpinningLines(
      color: getCustomColors(context).accent!,
    );
  }
}

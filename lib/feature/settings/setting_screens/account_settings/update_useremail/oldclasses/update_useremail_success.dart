import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../auth/u_auth.dart';
import '../../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../../general/utils_theme/custom_text_styles.dart';

class UpdateUseremailSuccess extends StatelessWidget {
  const UpdateUseremailSuccess({
    super.key,
    required this.nextStep,
  });

  final VoidCallback nextStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Updating Useremail was a complete success"),
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: () {
            nextStep();
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            backgroundColor: getCustomColors(context).accent,
            side: BorderSide(
              width: 0.5,
              color: getCustomColors(context).lightBorder ?? Colors.transparent,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Ok cool take me back",
            style: getCustomTextStyles(context).dataEditDialogButtonSaveStyle,
          ),
        ),
      ],
    );
  }
}

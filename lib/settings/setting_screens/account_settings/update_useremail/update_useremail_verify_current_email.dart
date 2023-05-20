import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../auth/u_auth.dart';
import '../../../../theme/custom_colors.dart';
import '../../../../theme/custom_text_styles.dart';

class UpdateUseremailVerifyCurrentEmail extends StatelessWidget {
  const UpdateUseremailVerifyCurrentEmail({
    super.key,
    required this.nextStep,
  });

  final VoidCallback nextStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Verify Current Email"),
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: () {
            sendVerificationEmail(null);
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
            "Verify Email",
            style: getCustomTextStyles(context).dataEditDialogButtonSaveStyle,
          ),
        ),
      ],
    );
  }
}

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../auth/u_auth.dart';
import '../../../../pets/profile_details/widgets/custom_textformfield.dart';
import '../../../../theme/custom_colors.dart';
import '../../../../theme/custom_text_styles.dart';

class UpdateUsermailNewCurrentEmailCode extends StatefulWidget {
  const UpdateUsermailNewCurrentEmailCode(
      {super.key, required this.nextStep, required this.newEmail});

  final VoidCallback nextStep;
  final String newEmail;

  @override
  State<UpdateUsermailNewCurrentEmailCode> createState() =>
      _UpdateUsermailNewCurrentEmailCodeState();
}

class _UpdateUsermailNewCurrentEmailCodeState
    extends State<UpdateUsermailNewCurrentEmailCode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text("Check code"),
          const SizedBox(height: 24),
          CustomTextFormField(
            textEditingController: textEditingController,
            labelText: "Code",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'I cannot be empty mate';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool codeCorrect = await checkVerificationCodeUpdateEmail(
                    widget.newEmail, textEditingController.text);
                if (codeCorrect) {
                  setState(() {
                    errorText = null;
                  });
                  widget.nextStep();
                } else {
                  setState(() {
                    errorText = "Code is not correct";
                  });
                }
              }
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              backgroundColor: getCustomColors(context).accent,
              side: BorderSide(
                width: 0.5,
                color:
                    getCustomColors(context).lightBorder ?? Colors.transparent,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Check Code",
              style: getCustomTextStyles(context).dataEditDialogButtonSaveStyle,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../pets/profile_details/widgets/custom_textformfield.dart';
import '../auth_widgets.dart';

class SignUpNamePage extends StatefulWidget {
  const SignUpNamePage({
    super.key,
    required this.onNext,
  });

  final Function(String) onNext;

  @override
  State<SignUpNamePage> createState() => _SignUpNamePageState();
}

class _SignUpNamePageState extends State<SignUpNamePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "namePageTitle".tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 02.h),
          Text(
            "namePageSubTitle".tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 05.h),
          CustomTextFormField(
            textEditingController: _textEditingController,
            labelText: "namePageInputLabel".tr(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "textInputErrorEmpty".tr();
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 05.h),
          CustomBigButton(
            label: "namePageContinueLabel".tr(),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                widget.onNext.call(_textEditingController.text);
              }
            },
          ),
          SizedBox(height: 05.h),
        ],
      ),
    );
  }
}

Widget? getEmailIcon(String emailtext, bool isAvailable) {
  if (emailtext.isNotEmpty && validEmail(emailtext)) {
    if (isAvailable) {
      return const Icon(Icons.check);
    } else {
      return const Icon(Icons.cancel);
    }
  } else {
    return null;
  }
}

bool validEmail(String email) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

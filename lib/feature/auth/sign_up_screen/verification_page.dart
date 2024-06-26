import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

import '../auth_widgets.dart';
import '../u_auth.dart';

class SignUpVerificationPage extends StatefulWidget {
  const SignUpVerificationPage({
    super.key,
    required this.useremail,
    required this.onCodeCorrect,
  });

  final Function(String) onCodeCorrect;
  final String useremail;

  @override
  State<SignUpVerificationPage> createState() => _SignUpVerificationPageState();
}

class _SignUpVerificationPageState extends State<SignUpVerificationPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  bool isCompleted = false;
  String currentText = "";

  @override
  void initState() {
    super.initState();
    createPendingAccount(widget.useremail);
  }

  void checkVerificationCode(String code) {
    checkCode(widget.useremail, code).then((value) {
      if (value) {
        widget.onCodeCorrect.call(code);
      } else {
        errorController?.add(ErrorAnimationType.shake);
        setState(() {
          hasError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "verificationPageTitle".tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 02.h),
        Text(
          "verificationPageInformation".tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 05.h),
        const Spacer(),
        PinCodeTextField(
          appContext: context,
          length: 6,
          autoFocus: true,
          hintCharacter: 'X',
          autoDismissKeyboard: true,
          obscureText: false,
          animationType: AnimationType.fade,
          cursorColor: getCustomColors(context).hardBorder,
          pinTheme: PinTheme(
            activeFillColor: Theme.of(context).primaryColor,
            activeColor: isCompleted
                ? getCustomColors(context).accent
                : getCustomColors(context).hardBorder,
            disabledColor: getCustomColors(context).lightBorder,
            selectedColor: getCustomColors(context).hardBorder,
            selectedFillColor: Theme.of(context).primaryColor,
            inactiveFillColor: Theme.of(context).primaryColor,
            inactiveColor: getCustomColors(context).hardBorder,
            borderWidth: 1,
            errorBorderColor: Colors.red,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            // fieldHeight: 50,
            // fieldWidth: 40,
          ),
          animationDuration: const Duration(milliseconds: 125),
          errorAnimationDuration: 380,
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: textEditingController,
          onCompleted: (v) {
            print("Completed");
            checkVerificationCode(currentText);
          },
          onChanged: (value) {
            print(value);
            if (value.length == 8) {
              isCompleted = true;
            } else {
              isCompleted = false;
            }
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
        SizedBox(height: 05.h),
        CustomBigButton(
          label: "verificationPageButtonLabel".tr(),
          onTap: () {
            if (currentText.length != 6) {
              print("not complete");
              errorController?.add(ErrorAnimationType.shake);
              setState(() {
                hasError = true;
              });
            } else {
              checkVerificationCode(currentText);
            }
          },
        ),
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }
}

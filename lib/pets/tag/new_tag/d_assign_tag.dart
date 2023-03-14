import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import '../../../pet_color/pet_colors.dart';
import '../../../styles/text_styles.dart';
import '../../u_pets.dart';

class AssignNewTagDialog extends StatefulWidget {
  const AssignNewTagDialog({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  final void Function() onCancel;
  final void Function(String) onSave;

  @override
  State<AssignNewTagDialog> createState() => _AssignNewTagDialogState();
}

class _AssignNewTagDialogState extends State<AssignNewTagDialog> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  bool isCompleted = false;
  String currentText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Colors.black, width: 2.5),
      ),
      elevation: 0,
      child: SizedBox(
        width: 80.w,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add new Finma Tag",
                style: pickerDialogTitleStyle,
              ),
              const SizedBox(height: 28),
              PinCodeTextField(
                appContext: context,
                length: 8,
                autoFocus: true,
                hintCharacter: 'X',
                autoDismissKeyboard: true,
                obscureText: false,
                animationType: AnimationType.fade,
                cursorColor: Colors.black,
                pinTheme: PinTheme(
                  activeFillColor: Colors.white,
                  activeColor: isCompleted ? Colors.green : Colors.black,
                  disabledColor: Colors.black.withOpacity(0.28),
                  selectedColor: Colors.black,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.black,
                  borderWidth: 2,
                  errorBorderColor: Colors.red,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  // fieldHeight: 50,
                  // fieldWidth: 40,
                ),
                animationDuration: const Duration(milliseconds: 125),
                errorAnimationDuration: 380,
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                // onCompleted: (v) {
                //   print("Completed");
                //   setState(() {
                //     isCompleted = true;
                //   });
                // },
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
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => widget.onCancel.call(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: dataEditDialogButtonCancelStyle,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (currentText.length != 8) {
                        print("not complete");
                        errorController?.add(ErrorAnimationType.shake);
                        setState(() {
                          hasError = true;
                        });
                      } else {
                        assignTagToUser(currentText).then((assignSuccessfull) {
                          if (assignSuccessfull) {
                            print("success");
                            setState(() {
                              hasError = false;
                            });
                            Navigator.pop(context);
                          } else {
                            print("cant assign");
                            errorController?.add(ErrorAnimationType.shake);
                            setState(() {
                              hasError = true;
                            });
                          }
                        });
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      backgroundColor: dataEditDialogButtonSave,
                      side: const BorderSide(width: 1, color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Save ahead",
                      style: dataEditDialogButtonSaveStyle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

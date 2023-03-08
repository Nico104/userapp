import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../../pet_color/pet_colors.dart';
import '../../../styles/text_styles.dart';

class OneLineSimpleDialog extends StatefulWidget {
  const OneLineSimpleDialog({
    super.key,
    required this.title,
    required this.onCancel,
    required this.onSave,
    required this.currentValue,
  });

  final String title;
  final String currentValue;
  final void Function() onCancel;
  final void Function(String) onSave;

  @override
  State<OneLineSimpleDialog> createState() => _OneLineSimpleDialogState();
}

class _OneLineSimpleDialogState extends State<OneLineSimpleDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.black, width: 2.5),
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
                widget.title,
                style: pickerDialogTitleStyle,
              ),
              const SizedBox(height: 28),
              TextFormField(
                autofocus: true,
                controller: _controller,
                cursorColor: Colors.black.withOpacity(0.74),
                decoration: InputDecoration(
                  hintText: "Enter Description",
                  fillColor: Colors.white,
                  suffixIconColor: Colors.grey,
                  suffixIcon: GestureDetector(
                    onTap: () => _controller.clear(),
                    child: const Icon(Icons.delete),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.75,
                    ),
                  ),
                ),
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
                    onPressed: () => widget.onSave.call(_controller.text),
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

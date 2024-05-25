import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'c_component_title.dart';
import 'widgets/custom_textformfield.dart';

class MultiSimpleInput extends StatelessWidget {
  const MultiSimpleInput({
    super.key,
    required this.value,
    required this.saveValue,
    required this.title,
    required this.emptyValuePlaceholder,
    // required this.flexSpacer,
  });

  final String value;
  final ValueSetter<String> saveValue;
  final String title;
  final String emptyValuePlaceholder;
  // final int flexSpacer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(text: title),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                showSuffix: false,
                initialValue: value,
                hintText: emptyValuePlaceholder,
                onChanged: (val) {
                  EasyDebounce.debounce(
                    '${title}debounce',
                    const Duration(milliseconds: 250),
                    () {
                      saveValue.call(val);
                    },
                  );
                },
              ),
            ),
            // Spacer(
            //   flex: flexSpacer,
            // ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
      ],
    );
  }
}

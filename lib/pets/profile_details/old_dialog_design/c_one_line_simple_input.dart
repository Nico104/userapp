import 'package:flutter/material.dart';
import '../../../styles/text_styles.dart';
import '../c_component_title.dart';
import 'one_line_simple_dialog.dart';

class OnelineSimpleInput extends StatelessWidget {
  const OnelineSimpleInput({
    super.key,
    required this.value,
    required this.saveValue,
    required this.title,
    required this.emptyValuePlaceholder,
  });

  final String value;
  final Future Function(String) saveValue;
  final String title;
  final String emptyValuePlaceholder;

  void askForValue(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => OneLineSimpleDialog(
        title: title,
        currentValue: value,
        onCancel: () => Navigator.pop(context),
        onSave: (val) => Navigator.pop(context, val),
      ),
    ).then((value) {
      if ((value as String).isNotEmpty) {
        //saveValue
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ComponentTitle(text: title),
            GestureDetector(
              onTap: () => askForValue(context),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: const Icon(
                  Icons.edit,
                  size: 18,
                ),
              ),
            )
          ],
        ),
        getValueText(value, emptyValuePlaceholder)
      ],
    );
  }
}

Text getValueText(String value, String placeholder) {
  if (value.isEmpty) {
    return Text(
      placeholder,
      style: profileDetailsDataPreviewTextEmptyValueStyle,
    );
  } else {
    return Text(
      value,
      style: profileDetailsDataPreviewTextStyle,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/tag/tags.dart';
import '../../styles/text_styles.dart';
import 'c_component_title.dart';
import 'widgets/one_line_simple_dialog.dart';

class PetChipNumber extends StatelessWidget {
  const PetChipNumber({
    super.key,
    required this.chipNr,
    required this.setchipNr,
  });

  final String chipNr;
  final ValueSetter<String> setchipNr;

  void askForNumber(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => OneLineSimpleDialog(
        title: "Chip Number",
        currentValue: chipNr,
        onCancel: () => Navigator.pop(context),
        onSave: (val) => Navigator.pop(context, val),
      ),
    ).then((value) {
      if ((value as String).isNotEmpty) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ComponentTitle(text: "Chip Number"),
              GestureDetector(
                onTap: () => askForNumber(context),
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  // color: Colors.amber,
                  child: const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
        ),
        Text(
          getChipText(chipNr),
          style: profileDetailsDataPreviewTextStyle,
        )
      ],
    );
  }
}

String getChipText(String value) {
  if (value.isEmpty) {
    return "No Chip Nr. entered";
  } else {
    return value;
  }
}

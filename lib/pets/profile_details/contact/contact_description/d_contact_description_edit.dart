import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:userapp/pet_color/hex_color.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

import '../../../../theme/custom_colors.dart';
import '../../../../theme/custom_text_styles.dart';
import '../../d_confirm_delete.dart';
import '../../models/m_contact_descripton.dart';
import '../../widgets/custom_textformfield.dart';
import '../u_contact.dart';

class ContactDescriptionEditDialog extends StatefulWidget {
  const ContactDescriptionEditDialog({
    super.key,
    required this.contactDescription,
    required this.onDelete,
    required this.onSave,
  });

  final ContactDescription contactDescription;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  @override
  State<ContactDescriptionEditDialog> createState() =>
      _ContactDescriptionEditDialogState();
}

class _ContactDescriptionEditDialogState
    extends State<ContactDescriptionEditDialog> {
  late String text;

  late Color pickerColor;
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    pickerColor = HexColor(widget.contactDescription.contactDescriptionHex);
    currentColor = HexColor(widget.contactDescription.contactDescriptionHex);
    text = widget.contactDescription.contactDescriptionLabel;
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const ConfirmDeleteDialog(
                          label: "Contact Description",
                        ),
                      ).then((value) {
                        if (value != null) {
                          if (value == true) {
                            widget.onDelete();
                            Navigator.pop(context);
                          }
                        }
                      });
                    },
                    child: const Icon(CustomIcons.delete),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              CustomTextFormField(
                initialValue: text,
                hintText: "Enter Contact Description",
                onChanged: (val) {
                  EasyDebounce.debounce(
                    'ContactDescription',
                    const Duration(milliseconds: 50),
                    () {
                      setState(() {
                        text = val;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 28),
              BlockPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                availableColors: getAvailableContactDescriptionColors(),
                layoutBuilder: (context, colors, child) {
                  Orientation orientation = MediaQuery.of(context).orientation;

                  return SizedBox(
                    width: 300,
                    // height: orientation == Orientation.portrait ? 360 : 200,
                    height: orientation == Orientation.portrait ? 380 : 200,
                    child: GridView.count(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 4 : 6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      children: [for (Color color in colors) child(color)],
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 8),
                  //Todo remove Outlined Button and stay with Containers to keep it the same everywhere - Extract Cancel Widget and Save Widget
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      side: BorderSide(
                        width: 0.5,
                        color: getCustomColors(context).lightBorder ??
                            Colors.transparent,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: getCustomTextStyles(context)
                          .dataEditDialogButtonCancelStyle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  DisableWidget(
                    disabled: text.isEmpty,
                    child: OutlinedButton(
                      onPressed: () {
                        widget.contactDescription.contactDescriptionLabel =
                            text;
                        widget.contactDescription.contactDescriptionHex =
                            pickerColor.toHexTriplet();
                        updateContactDescription(widget.contactDescription);
                        widget.onSave();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        backgroundColor: getCustomColors(context).accent,
                        side: BorderSide(
                          width: 0.5,
                          color: getCustomColors(context).lightBorder ??
                              Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: getCustomTextStyles(context)
                            .dataEditDialogButtonSaveStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DisableWidget extends StatelessWidget {
  const DisableWidget({super.key, required this.disabled, required this.child});

  final bool disabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Opacity(
        opacity: disabled ? 0.4 : 1,
        child: child,
      ),
    );
  }
}

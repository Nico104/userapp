import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

import '../../../theme/custom_colors.dart';
import '../../../theme/custom_text_styles.dart';

//Returns true if confirmation to delete
class ConfirmDeleteDialog extends StatefulWidget {
  const ConfirmDeleteDialog({
    super.key,
    required this.label,
  });

  final String label;

  @override
  State<ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<ConfirmDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: const Alignment(0, 0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 16,
      child: SizedBox(
        width: 80.w,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: getCustomColors(context).error ?? Colors.transparent,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  CustomIcons.delete,
                  color: getCustomColors(context).error,
                  size: 42,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Delete?",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                "You will delete this ${widget.label}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                "Are you sure?",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      backgroundColor: getCustomColors(context).error,
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
                      "Delete",
                      style: getCustomTextStyles(context)
                          .dataEditDialogButtonSaveStyle,
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';

import '../../../general/utils_theme/custom_colors.dart';
import '../../../general/utils_theme/custom_text_styles.dart';

//Returns true if confirmation to delete
class ConfirmDeleteDialog extends StatefulWidget {
  const ConfirmDeleteDialog({
    super.key,
    required this.label,
    this.remove = false,
  });

  final String label;
  final bool remove;

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
                widget.remove
                    ? "deleteAlerDialogRemove".tr()
                    : "deleteAlerDialogDelete".tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                widget.remove
                    ? 'deleteAlerDialogInfoTextRemove'
                        .tr(namedArgs: {'label': widget.label})
                    : 'deleteAlerDialogInfoTextDelete'
                        .tr(namedArgs: {'label': widget.label}),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                "deleteAlerDialogConfirmationText".tr(),
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
                      "deleteAlerDialogCancelButton".tr(),
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
                      "deleteAlerDialogDeleteButton".tr(),
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

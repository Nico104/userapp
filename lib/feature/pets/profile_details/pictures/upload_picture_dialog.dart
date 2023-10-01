import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

import '../../../../general/widgets/loading_indicator.dart';

class UploadPictureDialog extends StatelessWidget {
  const UploadPictureDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "uploadPictureDialog_uploadingPicture".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 28),
            CustomLoadingIndicatior(),
            const SizedBox(height: 28),
            Text(
              "uploadPictureDialog_pleaseDontExitScreen".tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

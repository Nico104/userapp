import 'package:flutter/material.dart';
import 'package:userapp/theme/custom_colors.dart';

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
              "Uploading Picture",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 28),
            CircularProgressIndicator(
              color: getCustomColors(context).accent,
            ),
            const SizedBox(height: 28),
            Text(
              "please don't exit Screen",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

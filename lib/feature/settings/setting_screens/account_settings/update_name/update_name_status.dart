import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/u_auth.dart';

import '../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../general/utils_theme/custom_text_styles.dart';
import '../../../../../general/widgets/custom_nico_modal.dart';

class UpdateNameStatus extends StatelessWidget {
  const UpdateNameStatus({
    super.key,
    required this.displayName,
  });

  final String displayName;

  @override
  Widget build(BuildContext context) {
    return CustomNicoModalBottomSheet(
      child: FutureBuilder(
        future: updateDisplayName(displayName),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            // makeDissmissable();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Name chnaged successfully mate"),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
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
                    "Got it",
                    style: getCustomTextStyles(context)
                        .dataEditDialogButtonSaveStyle,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            // makeDissmissable();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    "Probelms updating your name, please make sure you're online"),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
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
                    "Got it",
                    style: getCustomTextStyles(context)
                        .dataEditDialogButtonSaveStyle,
                  ),
                ),
              ],
            );
          } else {
            //Loading
            return const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

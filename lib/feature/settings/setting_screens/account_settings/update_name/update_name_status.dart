import 'package:easy_localization/easy_localization.dart';
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
                Text("updateNameStatus_Success".tr()),
              ],
            );
          } else if (snapshot.hasError) {
            // makeDissmissable();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("updateNameStatus_Error1".tr()),
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

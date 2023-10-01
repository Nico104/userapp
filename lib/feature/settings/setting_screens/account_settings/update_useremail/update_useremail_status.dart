import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/u_auth.dart';
import 'package:userapp/general/widgets/custom_nico_modal.dart';

import '../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../general/utils_theme/custom_text_styles.dart';
import '../../../../../general/widgets/loading_indicator.dart';

class UpdateEmailStatus extends StatelessWidget {
  const UpdateEmailStatus({
    super.key,
    required this.currentPassword,
    required this.onUnexcpectedError,
    required this.onWrongPassword,
    required this.onSuccess,
    required this.newEmail,
    // required this.makeDissmissable,
  });

  final String currentPassword;
  final String newEmail;
  final VoidCallback onUnexcpectedError;
  final VoidCallback onWrongPassword;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return CustomNicoModalBottomSheet(
      child: FutureBuilder(
        future: changeEmail(currentPassword, newEmail),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data) {
              case 0:
                onSuccess();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updateEmailStatus_Success".tr()),
                  ],
                );
              case 2:
                onWrongPassword();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updateEmailStatus_WrongPassword".tr()),
                  ],
                );
              case 3:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updateEmailStatus_tooManyFailedRequests".tr()),
                  ],
                );
              case 4:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updateEmailStatus_EmailInvalid".tr()),
                  ],
                );
              case 5:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updateEmailStatus_EmailInUse".tr()),
                  ],
                );
              default:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updateEmailStatus_UnexpectedError".tr()),
                  ],
                );
            }
          } else {
            //Loading
            return const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CustomLoadingIndicatior(),
              ),
            );
          }
        },
      ),
    );
  }
}

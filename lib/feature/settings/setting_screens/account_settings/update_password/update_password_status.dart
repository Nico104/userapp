import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/u_auth.dart';

import '../../../../../general/widgets/loading_indicator.dart';

class UpdatePasswordStatus extends StatelessWidget {
  const UpdatePasswordStatus({
    super.key,
    required this.newPassword,
    required this.currentPassword,
    required this.onUnexcpectedError,
    required this.onWrongPassword,
    required this.onSuccess,
    // required this.makeDissmissable,
  });

  final String currentPassword;
  final String newPassword;
  final VoidCallback onUnexcpectedError;
  final VoidCallback onWrongPassword;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: FutureBuilder(
        future: changePassword(currentPassword, newPassword),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data) {
              case 0:
                onSuccess();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updatePasswordStatus_Success".tr()),
                  ],
                );
              case 2:
                onWrongPassword();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updatePasswordStatus_WrongPassword".tr()),
                  ],
                );
              case 3:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updatePasswordStatus_tooManyFailedRequests".tr()),
                  ],
                );
              default:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("updatePasswordStatus_UnexpectedError".tr()),
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

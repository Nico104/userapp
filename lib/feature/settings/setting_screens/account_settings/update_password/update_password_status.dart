import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/u_auth.dart';

import '../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../general/utils_theme/custom_text_styles.dart';

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
                    const Text("Password updates successfully mate"),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, 0);
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
              case 2:
                onWrongPassword();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("You provided the wrong current Password"),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, 2);
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
              case 3:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Too many failed requests. Try again later bro"),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, 2);
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
              default:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        "Probelms updating your password, please make sure you're online"),
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
            }
          } else {
            //Loading
            return const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

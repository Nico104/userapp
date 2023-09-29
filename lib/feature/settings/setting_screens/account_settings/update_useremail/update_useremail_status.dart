import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/u_auth.dart';
import 'package:userapp/general/widgets/custom_nico_modal.dart';

import '../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../general/utils_theme/custom_text_styles.dart';

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
                    const Text("Email updated successfully mate"),
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
              case 4:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Your new Email provided is invalid bruv"),
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
              case 5:
                onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        "Your new Email provided is already in use bruv. Who are you?"),
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

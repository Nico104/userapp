import 'package:flutter/material.dart';
import 'package:userapp/auth/u_auth.dart';

import '../../../../theme/custom_colors.dart';
import '../../../../theme/custom_text_styles.dart';

class ForgotPasswordStatus extends StatelessWidget {
  const ForgotPasswordStatus({
    super.key,
    required this.onUnexcpectedError,
    required this.onInvalidEmail,
    required this.onSuccess,
    required this.email,
    required this.onNoUserFound,
  });

  final String email;
  final VoidCallback onUnexcpectedError;
  final VoidCallback onNoUserFound;
  final VoidCallback onInvalidEmail;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: FutureBuilder(
        future: resetPassword(email: email),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data) {
              case 0:
                onSuccess();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Password reset email send"),
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
                onInvalidEmail();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("You provided an invalid email"),
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
                onNoUserFound();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("No user with provided email found"),
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
                        "There has been an error. Please try again later"),
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

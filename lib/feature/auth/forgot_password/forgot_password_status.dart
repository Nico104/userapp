import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/u_auth.dart';

import '../../../general/utils_theme/custom_colors.dart';
import '../../../general/utils_theme/custom_text_styles.dart';
import '../../../general/widgets/future_error_widget.dart';
import '../../../general/widgets/loading_indicator.dart';

class ForgotPasswordStatus extends StatefulWidget {
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
  State<ForgotPasswordStatus> createState() => _ForgotPasswordStatusState();
}

class _ForgotPasswordStatusState extends State<ForgotPasswordStatus> {
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
        future: resetPassword(email: widget.email),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data) {
              case 0:
                widget.onSuccess();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "forgotPasswordStatusSendSuccess".tr(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    // const SizedBox(height: 16),
                    // OutlinedButton(
                    //   onPressed: () {
                    //     Navigator.pop(context, 0);
                    //   },
                    //   style: OutlinedButton.styleFrom(
                    //     padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                    //     backgroundColor: getCustomColors(context).accent,
                    //     side: BorderSide(
                    //       width: 0.5,
                    //       color: getCustomColors(context).lightBorder ??
                    //           Colors.transparent,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    //   child: Text(
                    //     "Got it",
                    //     style: getCustomTextStyles(context)
                    //         .dataEditDialogButtonSaveStyle,
                    //   ),
                    // ),
                  ],
                );
              case 2:
                widget.onInvalidEmail();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "forgotPasswordStatusErrorInvalidEmail".tr(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                );
              case 3:
                widget.onNoUserFound();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "forgotPasswordStatusErrorNoUserFound".tr(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                );
              default:
                widget.onUnexcpectedError();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "forgotPasswordStatusErrorUnexpextedError".tr(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                );
            }
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureErrorWidget(),
                  ),
                ).then((value) => setState(
                      () {},
                    )));
            return const SizedBox.shrink();
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

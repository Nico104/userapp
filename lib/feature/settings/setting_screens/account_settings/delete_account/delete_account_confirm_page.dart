import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/login_screen.dart';
import 'package:userapp/feature/pets/profile_details/d_confirm_delete.dart';
import 'package:userapp/feature/pets/profile_details/pages/pet_page.dart';
import 'package:userapp/general/utils_general.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';
import 'package:userapp/general/widgets/shy_button.dart';
import 'package:userapp/init_app.dart';

import '../../../../auth/u_auth.dart';
import 'delete_account_type_password.dart';

class DeleteAccountConfirmPage extends StatefulWidget {
  const DeleteAccountConfirmPage({
    super.key,
    required this.reason,
    required this.message,
  });

  final String reason;
  final String message;

  @override
  State<DeleteAccountConfirmPage> createState() =>
      _DeleteAccountConfirmPageState();
}

class _DeleteAccountConfirmPageState extends State<DeleteAccountConfirmPage> {
  final groubId = 12;

  String? activeOption;
  bool _showShyButton = true;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomNicoScrollView(
            title: Text("deleteAccountTitle3".tr()),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("deleteAccountConfrimDeleteInfo3".tr(),
                      style: Theme.of(context).textTheme.displayMedium),
                ),
                const SizedBox(height: 16),
              ],
            ),
            onScroll: () => handleShyButtonShown(
              setShowShyButton: (p0) {
                setState(() {
                  _showShyButton = p0;
                });
              },
            ),
          ),
          ShyButton(
            showUploadButton: _showShyButton,
            onTap: () async {
              showDialog(
                context: context,
                builder: (_) => const ConfirmDeleteDialog(
                  label: "Account",
                ),
              ).then((value) async {
                if (value != null) {
                  if (value == true) {
                    deleteUser(
                      message: widget.message,
                      reason: widget.reason,
                    ).then((value) {
                      navigateReplacePerSlide(context, const LoginScreen());
                    });
                  } else {
                    navigateReplacePerSlide(context, const InitApp());
                  }
                } else {
                  navigateReplacePerSlide(context, const InitApp());
                }
              });

              // Navigator.of(context)
              //     .push(
              //   PageRouteBuilder(
              //     opaque: false,
              //     barrierDismissible: true,
              //     pageBuilder: (BuildContext context, _, __) {
              //       return const DeleteAccountTypePassword();
              //     },
              //   ),
              // )
              //     .then(
              //   (value) async {
              //     if (value == true) {
              //       await deleteUser(
              //         message: widget.message,
              //         reason: widget.reason,
              //       );
              //     }
              //   },
              // );
            },
            label: "deleteAccountTitleConfirmDeleteButtonLabel3".tr(),
          ),
        ],
      ),
    );
  }
}

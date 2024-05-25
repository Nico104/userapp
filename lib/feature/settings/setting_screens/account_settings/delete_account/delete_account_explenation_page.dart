import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';
import 'package:userapp/general/widgets/shy_button.dart';

import '../../../../../general/utils_general.dart';
import 'delete_account_confirm_page.dart';

class DeleteAccountExplenationPage extends StatefulWidget {
  const DeleteAccountExplenationPage({super.key, required this.reason});

  final String reason;

  @override
  State<DeleteAccountExplenationPage> createState() =>
      _DeleteAccountExplenationPageState();
}

class _DeleteAccountExplenationPageState
    extends State<DeleteAccountExplenationPage> {
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
            title: Text("deleteAccountTitle2".tr()),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("deleteAccountInfo2".tr(),
                      style: Theme.of(context).textTheme.displayMedium),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomTextFormField(
                    textEditingController: _textEditingController,
                    hintText: "deleteAccountHintTextMessage2".tr(),
                    maxLines: null,
                    // expands: true,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    onChanged: (val) {},
                    showSuffix: false,
                  ),
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
            onTap: () {
              navigatePerSlide(
                context,
                DeleteAccountConfirmPage(
                  message: _textEditingController.text,
                  reason: widget.reason,
                ),
              );
            },
            label: "deleteAccountButtonLabel2".tr(),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/settings/setting_screens/account_settings/delete_account/delete_account_explenation_page.dart';
import 'package:userapp/general/utils_general.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';
import 'package:userapp/general/widgets/shy_button.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final groubId = 12;

  String? activeOption;
  bool _showShyButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomNicoScrollView(
            title: Text("deleteAccountTitle1".tr()),
            body: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title: Text(options.elementAt(index)),
                      value: options.elementAt(index),
                      groupValue: activeOption,
                      onChanged: (value) {
                        setState(() {
                          activeOption = value;
                          print("Button value: $value");
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: 30.h),
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
          IgnorePointer(
            ignoring: activeOption != null ? false : true,
            child: Opacity(
              opacity: activeOption != null ? 1 : 0.4,
              child: ShyButton(
                showUploadButton: _showShyButton,
                onTap: () {
                  navigatePerSlide(
                      context,
                      DeleteAccountExplenationPage(
                        reason: activeOption ?? "",
                      ));
                },
                label: "deleteAccountButtonLabel1".tr(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

final List<String> options = [
  "Change in Interests",
  "Information Overload",
];

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auth/auth_widgets.dart';
import 'package:userapp/feature/settings/setting_screens/contact_us/contact_success_page.dart';
import 'package:userapp/general/utils_general.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../../pets/profile_details/widgets/custom_textformfield.dart';
import '../../../pets/profile_details/widgets/shy_button.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showShyButton = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          CustomNicoScrollView(
            fillRemaining: true,
            onScroll: () => handleShyButtonShown(
              setShowShyButton: (p0) {
                setState(() {
                  _showShyButton = p0;
                });
              },
            ),
            title: Text("Get in touch"),
            body: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      // textEditingController: _textEditingController,
                      // ignoreBoxShadow: true,
                      // thickUnfocusedBorder: true,
                      maxLines: 1,
                      showSuffix: false,
                      // expands: true,
                      labelText: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "textInputErrorEmpty".tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      // textEditingController: _textEditingController,
                      // ignoreBoxShadow: true,
                      // thickUnfocusedBorder: true,
                      maxLines: 1,
                      showSuffix: false,
                      // expands: true,
                      labelText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "textInputErrorEmpty".tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 40.h,
                      child: CustomTextFormField(
                        textEditingController: _textEditingController,
                        // ignoreBoxShadow: true,
                        // thickUnfocusedBorder: true,
                        maxLines: null,
                        showSuffix: false,
                        expands: true,
                        labelText: "Message",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "textInputErrorEmpty".tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 60.h),
                  ],
                ),
              ),
            ),
          ),
          ShyButton(
            showUploadButton: _showShyButton,
            icon: Icon(
              Icons.mail_outline_rounded,
              color: Colors.white,
            ),
            label: "Send",
            onTap: () {
              navigateReplacePerSlide(context, ContactUsSuccessPage());
            },
          ),
        ],
      ),
    );
  }
}

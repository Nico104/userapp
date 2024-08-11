import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/feature/settings/setting_screens/contact_us/contact_us_success_page.dart';
import 'package:userapp/feature/settings/setting_screens/contact_us/u_contact_us.dart';
import 'package:userapp/general/utils_general.dart';
import 'package:userapp/general/widgets/custom_nico_modal.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../../pets/profile_details/widgets/custom_textformfield.dart';
import '../../../../general/widgets/shy_button.dart';

void showContactUsOptions(BuildContext context) {
  showCustomNicoModalBottomSheet(
    context: context,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.mail_outline_rounded),
          title: Text("Email us".tr()),
          onTap: () {
            Navigator.pop(context);
            // To create email with params
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: contactEmail,
              queryParameters: {
                'subject': "This is my subject",
                'body': "Hey Kashish here goes the body"
              },
            );
            launchUrl(emailLaunchUri);
          },
        ),
        ListTile(
          leading: const Icon(Icons.copy),
          title: Text("Copy Email Address".tr()),
          onTap: () async {
            Navigator.pop(context);
            await Clipboard.setData(ClipboardData(text: contactEmail));
          },
        ),
      ],
    ),
  );
}

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _textEditingControllerMessage =
      TextEditingController();
  final TextEditingController _textEditingControllerName =
      TextEditingController();
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
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
            title: const Text("Get in touch"),
            body: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      textEditingController: _textEditingControllerName,
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
                      textEditingController: _textEditingControllerEmail,
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
                        textEditingController: _textEditingControllerMessage,
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
            icon: const Icon(
              Icons.mail_outline_rounded,
              color: Colors.white,
            ),
            label: "Send",
            onTap: () {
              createContactUsMessage(
                categorie: "Message",
                text: _textEditingControllerMessage.text,
                declared_name: _textEditingControllerName.text,
                declared_email: _textEditingControllerEmail.text,
              );
              navigateReplacePerSlide(context, const ContactUsSuccessPage());
            },
          ),
        ],
      ),
    );
  }
}

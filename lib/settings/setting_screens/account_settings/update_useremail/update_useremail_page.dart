import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/auth_widgets.dart';
import '../../../../pets/profile_details/widgets/custom_textformfield.dart';

///1. You present the editable section where the user can update the email address.
///2.  Once the user changes the email, a confirmation email is sent to the new email address which contains a link to verify the email address. Note that you don't update the email address in database till now.
///3. Once the user verifies the email using the link sent to the new email address (Or a code whichever floats your boat), you update the email address in your backend. Also, note that the link has an expiry time. Beyond the expiry time, the link becomes useless.
///4. As a security measure, you send an email to the old email address which contains a message about the action which is performed recently. Along with the message, you share a help/support link for the user to contact you in case of the action was not performed by him.
///5. If the user contacts you about the unauthorized action in his account, you verify the critical information related to the user and then takes necessary action.

class UpdateUseremailPage extends StatefulWidget {
  const UpdateUseremailPage({
    super.key,
    required this.currentPassword,
  });

  final String currentPassword;

  @override
  State<UpdateUseremailPage> createState() => _UpdateUseremailPageState();
}

class _UpdateUseremailPageState extends State<UpdateUseremailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _currentPassword = "";
  String _password = "";
  String _passwordRepeat = "";

  // bool _isDissmissable = false;

  void _updatePassword() {
    // showModalBottomSheet(
    //     // enableDrag: _isDissmissable,
    //     // isDismissible: _isDissmissable,
    //     context: context,
    //     backgroundColor: Colors.transparent,
    //     builder: (context) {
    //       return UpdatePasswordStatus(
    //         newPassword: _passwordRepeat,
    //         // makeDissmissable: () {
    //         //   setState(() {
    //         //     _isDissmissable = true;
    //         //   });
    //         // },
    //       );
    //     }).then((value) {
    //   Navigator.pop(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Update your Password",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 02.h),
              Text(
                "Please enter your exisitng password and your new password.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 05.h),
              const Spacer(),
              CustomTextFormField(
                isPassword: true,
                onChanged: (value) {
                  EasyDebounce.debounce(
                    'currentPassword',
                    const Duration(milliseconds: 250),
                    () async {
                      if (_currentPassword != value) {
                        setState(() {
                          _currentPassword = value;
                        });
                      }
                    },
                  );
                },
                labelText: "Current Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'I cannot be empty mate';
                  } else if (value.length < 8) {
                    return 'I must be at least 8 characters mate';
                  } else if (value != widget.currentPassword) {
                    return 'I am not your current Password mate';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 04.h),
              CustomTextFormField(
                isPassword: true,
                onChanged: (value) {
                  EasyDebounce.debounce(
                    'currentPassword',
                    const Duration(milliseconds: 250),
                    () async {
                      if (_password != value) {
                        setState(() {
                          _password = value;
                        });
                      }
                    },
                  );
                },
                labelText: "New Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'I cannot be empty mate';
                  } else if (value.length < 8) {
                    return 'I must be at least 8 characters mate';
                  } else if (value == widget.currentPassword) {
                    return 'Password is too similar to your current Password my pawsome friend';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 02.h),
              CustomTextFormField(
                isPassword: true,
                onChanged: (value) {
                  EasyDebounce.debounce(
                    'currentPassword',
                    const Duration(milliseconds: 250),
                    () async {
                      if (_passwordRepeat != value) {
                        setState(() {
                          _passwordRepeat = value;
                        });
                      }
                    },
                  );
                },
                labelText: "Repeat New Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'I cannot be empty mate';
                  } else if (value != _password) {
                    return 'I must be the equal to the other password mate';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 05.h),
              Padding(
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: CustomBigButton(
                  label: "Change Password",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigator.pop(context);
                      _updatePassword();
                    }
                  },
                ),
              ),
              const Spacer(flex: 14),
            ],
          ),
        ),
      ),
    );
  }
}

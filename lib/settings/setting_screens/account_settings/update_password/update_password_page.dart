import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/auth_widgets.dart';
import '../../../../pets/profile_details/widgets/custom_textformfield.dart';
import 'update_password_status.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({
    super.key,
  });

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordRepeat = TextEditingController();

  int _statusCode = 0;

  void _updatePassword() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return UpdatePasswordStatus(
            currentPassword: _currentPassword.text,
            newPassword: _passwordRepeat.text,
            onUnexcpectedError: () {
              _statusCode = 1;
            },
            onWrongPassword: () {
              _statusCode = 2;
            },
            onSuccess: () {
              _statusCode = 0;
            },
          );
        }).then((value) {
      if (_statusCode == 1) {
        setState(() {
          _currentPassword.text = '';
          _password.text = '';
          _passwordRepeat.text = '';
        });
      } else if (_statusCode == 2) {
        setState(() {
          _currentPassword.text = '';
        });
      } else {
        Navigator.pop(context);
      }
    });
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
                // onChanged: (value) {
                //   EasyDebounce.debounce(
                //     'currentPassword',
                //     const Duration(milliseconds: 250),
                //     () async {
                //       if (_currentPassword != value) {
                //         setState(() {
                //           _currentPassword = value;
                //         });
                //       }
                //     },
                //   );
                // },
                textEditingController: _currentPassword,
                labelText: "Current Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'I cannot be empty mate';
                  } else if (value.length < 8) {
                    return 'I must be at least 8 characters mate';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 04.h),
              CustomTextFormField(
                isPassword: true,
                // onChanged: (value) {
                //   EasyDebounce.debounce(
                //     'currentPassword',
                //     const Duration(milliseconds: 250),
                //     () async {
                //       if (_password != value) {
                //         setState(() {
                //           _password = value;
                //         });
                //       }
                //     },
                //   );
                // },
                textEditingController: _password,
                labelText: "New Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'I cannot be empty mate';
                  } else if (value.length < 8) {
                    return 'I must be at least 8 characters mate';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 02.h),
              CustomTextFormField(
                isPassword: true,
                // onChanged: (value) {
                //   EasyDebounce.debounce(
                //     'currentPassword',
                //     const Duration(milliseconds: 250),
                //     () async {
                //       if (_passwordRepeat != value) {
                //         setState(() {
                //           _passwordRepeat = value;
                //         });
                //       }
                //     },
                //   );
                // },
                textEditingController: _passwordRepeat,
                labelText: "Repeat New Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'I cannot be empty mate';
                  } else if (value != _password.text) {
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

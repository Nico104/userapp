import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/auth_widgets.dart';
import '../../../../pets/profile_details/widgets/custom_textformfield.dart';
import 'update_password_status.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({
    super.key,
    required this.currentPassword,
  });

  final String currentPassword;

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _currentPassword = "";
  String _password = "";
  String _passwordRepeat = "";

  void _updatePassword() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return UpdatePasswordStatus(
            newPassword: _passwordRepeat,
          );
        }).then((value) {
      Navigator.pop(context);
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

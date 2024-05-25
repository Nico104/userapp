import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auth/auth_widgets.dart';
import '../../../../pets/profile_details/widgets/custom_textformfield.dart';
import 'update_password_status.dart';
import 'package:easy_localization/easy_localization.dart';

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
                "updatePasswordTitle".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 02.h),
              Text(
                "updatePasswordDescription".tr(),
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
                labelText: "updatePasswordCurrentPasswordLabel".tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "textInputErrorEmpty".tr();
                  } else if (value.length < 8) {
                    return 'passwordPageErrorMinLenght'.tr();
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
                labelText: "updatePasswordNewPasswordLabel".tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "textInputErrorEmpty".tr();
                  } else if (value.length < 8) {
                    return 'passwordPageErrorMinLenght'.tr();
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
                labelText: "updatePasswordRepeatNewPasswordLabel".tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "textInputErrorEmpty".tr();
                  } else if (value != _password.text) {
                    return 'passwordPageErrorNotEqual'.tr();
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 05.h),
              CustomBigButton(
                label: "updatePasswordChangePasswordLabel".tr(),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigator.pop(context);
                    _updatePassword();
                  }
                },
              ),
              const Spacer(flex: 14),
            ],
          ),
        ),
      ),
    );
  }
}

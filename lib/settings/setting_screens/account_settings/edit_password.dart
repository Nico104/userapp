import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/auth_widgets.dart';
import 'package:userapp/styles/text_styles.dart';

import '../../../pet_color/hex_color.dart';
import '../../../pets/profile_details/widgets/custom_textformfield.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({
    super.key,
    required this.currentPassword,
  });

  final String currentPassword;

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String currentPassword = "";
  String password = "";
  String passwordRepeat = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
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
              CustomTextFormFieldActive(
                isPassword: true,
                onChanged: (value) {
                  EasyDebounce.debounce(
                    'currentPassword',
                    const Duration(milliseconds: 250),
                    () async {
                      if (currentPassword != value) {
                        setState(() {
                          currentPassword = value;
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
                  } else if (value != widget.currentPassword) {
                    return 'I am not your current Password mate';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 04.h),
              CustomTextFormFieldActive(
                isPassword: true,
                onChanged: (value) {
                  EasyDebounce.debounce(
                    'currentPassword',
                    const Duration(milliseconds: 250),
                    () async {
                      if (password != value) {
                        setState(() {
                          password = value;
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
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 02.h),
              CustomTextFormFieldActive(
                isPassword: true,
                onChanged: (value) {
                  EasyDebounce.debounce(
                    'currentPassword',
                    const Duration(milliseconds: 250),
                    () async {
                      if (passwordRepeat != value) {
                        setState(() {
                          passwordRepeat = value;
                        });
                      }
                    },
                  );
                },
                labelText: "Repeat New Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'I cannot be empty mate';
                  } else if (value != password) {
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
                      Navigator.pop(context);
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

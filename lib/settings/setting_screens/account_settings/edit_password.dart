import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/styles/text_styles.dart';

import '../../../pet_color/hex_color.dart';

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
  TextEditingController currentPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    currentPassword.dispose();
    password.dispose();
    passwordRepeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("50ffaf"),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: HexColor("50ffaf"),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Update your Password",
                textAlign: TextAlign.center,
                style: loginTitle1,
              ),
              SizedBox(height: 02.h),
              Text(
                "Please enter your exisitng password and your new password.",
                textAlign: TextAlign.center,
                style: loginTitle2,
              ),
              SizedBox(height: 05.h),
              const Spacer(),
              TextFormField(
                controller: currentPassword,
                obscureText: _obscureCurrentPassword,
                cursorColor: Colors.black.withOpacity(0.74),
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 14.0),
                  labelText: "Current Password",
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                    child: Icon(
                      _obscureCurrentPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
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
              TextFormField(
                controller: password,
                obscureText: _obscurePassword,
                cursorColor: Colors.black.withOpacity(0.74),
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 14.0),
                  labelText: "New Password",
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
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
              TextFormField(
                controller: passwordRepeat,
                obscureText: _obscurePassword,
                cursorColor: Colors.black.withOpacity(0.74),
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 14.0),
                  labelText: "Repeat New Password",
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'I cannot be empty mate';
                  } else if (value != password.text) {
                    return 'I must be the equal to the other password mate';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 05.h),
              Padding(
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: HexColor("8F8FFF"),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                        // strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text(
                      "Change Password",
                      style: loginButton,
                    )),
                  ),
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

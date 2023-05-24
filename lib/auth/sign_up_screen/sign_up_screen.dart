import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/login_screen.dart';
import 'package:userapp/auth/sign_up_screen/verification_page.dart';
import 'package:userapp/auth/u_auth.dart';
import 'package:userapp/utils/util_methods.dart';

import '../../theme/custom_text_styles.dart';
import 'email_page.dart';
import 'name_page.dart';
import 'password_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.reloadInitApp,
  });

  final VoidCallback reloadInitApp;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController controller = PageController();

  String? _email;
  String? _password;
  String? _name;
  // String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: 100.h,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 76, 28, 28),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: <Widget>[
                      SignUpEmailPage(
                        reloadInitApp: widget.reloadInitApp,
                        onNext: (useremail) {
                          setState(() {
                            _email = useremail;
                          });
                          controller.animateToPage(1,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.fastOutSlowIn);
                        },
                      ),
                      SignUpNamePage(
                        onNext: (name) {
                          setState(() {
                            name = name;
                          });
                          controller.animateToPage(2,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.fastOutSlowIn);
                        },
                      ),
                      SignUpPasswordPage(
                        onNext: (userpassword) {
                          // setState(() {
                          //   _password = userpassword;
                          // });
                          // controller.animateToPage(3,
                          //     duration: const Duration(milliseconds: 250),
                          //     curve: Curves.fastOutSlowIn);

                          registerWithEmailPassword(
                            email: _email!,
                            password: userpassword,
                          ).then((value) => print(value));
                        },
                      ),
                      //Sends Code on init Verification Page
                      SignUpVerificationPage(
                        useremail: _email ?? "",
                        onCodeCorrect: (code) {
                          print(
                              _email.toString() + _password.toString() + code);
                          signUpUser(
                            useremail: _email!,
                            password: _password!,
                            name: _name!,
                            verificationCode: code,
                          ).then((successFullSignUp) {
                            if (successFullSignUp) {
                              login(_email!, _password!, true).then(
                                (loginSuccessfull) {
                                  if (loginSuccessfull) {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    widget.reloadInitApp.call();
                                  } else {
                                    print("error in SignUp Process");
                                  }
                                },
                              );
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
                // Spacer(),
                SizedBox(height: 03.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member? ",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigatePerSlide(
                          context,
                          LoginScreen(
                            reloadInitApp: () => widget.reloadInitApp(),
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => LoginScreen(
                        //       reloadInitApp: () => widget.reloadInitApp(),
                        //     ),
                        //   ),
                        // );
                      },
                      child: Text(
                        "Log In now",
                        style:
                            getCustomTextStyles(context).authRegisterNowAction,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

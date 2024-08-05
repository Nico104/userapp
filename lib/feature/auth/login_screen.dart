//ChatGPT Input

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auth/sign_up_screen/sign_up_screen.dart';
import 'package:userapp/feature/auth/u_auth.dart';
import 'package:userapp/general/utils_general.dart';

import '../../general/widgets/custom_nico_modal.dart';
import '../../init_app.dart';
import '../pets/profile_details/widgets/custom_textformfield.dart';
import '../../general/utils_theme/custom_colors.dart';
import 'auth_widgets.dart';
import 'forgot_password/forgot_password_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailText = "";
  String passwordText = "";
  String? _emailErrorMsg;
  String? _passwordErrorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(28, 76, 28, 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Expanded(child: Image.asset("assets/tmp/startLogo.png")),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  "loginPageTitle".tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 2.h),
                Text(
                  "loginPageSubTitle".tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 4.h),
                CustomTextFormField(
                  onChanged: (value) => _debounceEmail(value),
                  errorText: _emailErrorMsg,
                  labelText: "loginPageEmailInputLabel".tr(),
                ),
                SizedBox(height: 2.h),
                CustomTextFormField(
                  isPassword: true,
                  onChanged: (value) => _debouncePassword(value),
                  errorText: _passwordErrorMsg,
                  labelText: "loginPagePasswordInputLabel".tr(),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _navigateToForgotPassword(context),
                      child: Text(
                        "forgotPassword".tr(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  // width: 70.w,
                  child: CustomBigButton(
                    label: "loginPageContinueLabel".tr(),
                    onTap: () => _handleLogin(context),
                  ),
                ),
                SizedBox(height: 5.h),
                // const ContinueWithSocialMedia(),
                const ContinueWithGoogle(),
              ],
            ),

            const Spacer(),
            // _buildVersionInfo(),
            _buildRegisterNow(context),
          ],
        ),
      ),
    );
  }

  void _debounceEmail(String value) {
    EasyDebounce.debounce(
      'emailLoginPage',
      const Duration(milliseconds: 250),
      () {
        if (emailText != value) {
          setState(() {
            emailText = value;
          });
        }
      },
    );
  }

  void _debouncePassword(String value) {
    EasyDebounce.debounce(
      'passwordLoginPage',
      const Duration(milliseconds: 250),
      () {
        if (passwordText != value) {
          setState(() {
            passwordText = value;
          });
        }
      },
    );
  }

  void _navigateToForgotPassword(BuildContext context) {
    navigatePerSlide(context, const ForgotPasswordPage());
  }

  void _handleLogin(BuildContext context) {
    showCustomNicoLoadingModalBottomSheet(
      context: context,
      future: signInWithEmailPassword(email: emailText, password: passwordText),
      callback: (user) {
        if (user != null) {
          setState(() {
            _emailErrorMsg = null;
            _passwordErrorMsg = null;
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
          navigateReplacePerSlide(context, const InitApp());
        } else {
          setState(() {
            _emailErrorMsg = "This doesn't seem right";
            _passwordErrorMsg = "Are you sure? Cause I am not";
          });
        }
      },
    );
  }

  Widget _buildVersionInfo() {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasData) {
          return Text(
            "Version: ${snapshot.data!.version}",
            style: Theme.of(context).textTheme.labelSmall,
          );
        } else if (snapshot.hasError) {
          return Text(
            "error loading version",
            style: Theme.of(context).textTheme.labelSmall,
          );
        } else {
          return Text(
            "Loading Version",
            style: Theme.of(context).textTheme.labelSmall,
          );
        }
      },
    );
  }

  Widget _buildRegisterNow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Not a member? ",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            navigateReplacePerSlide(
              context,
              const SignUpScreen(),
            );
          },
          child: Text(
            "Register now",
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: getCustomColors(context).secondaryAccent),
          ),
        ),
      ],
    );
  }
}

//Remembr me fopr default makes more sense
// class RememberMe extends StatelessWidget {
//   const RememberMe({super.key, required this.rememberMe});

//   final bool rememberMe;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           height: 22,
//           width: 22,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: rememberMe
//                 ? getCustomColors(context).accentLessContrast
//                 : Colors.white,
//             border: Border.all(
//               width: 0.5,
//               color: getCustomColors(context).hardBorder ?? Colors.transparent,
//             ),
//             borderRadius: BorderRadius.circular(2),
//             boxShadow: kElevationToShadow[2],
//           ),
//           child: rememberMe
//               ? const Icon(
//                   Icons.check,
//                   size: 20,
//                 )
//               : null,
//         ),
//         const SizedBox(width: 8),
//         Text("Remember Me", style: Theme.of(context).textTheme.labelSmall),
//       ],
//     );
//   }
// }

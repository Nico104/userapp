// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import 'package:sizer/sizer.dart';
// import 'package:userapp/auth/login_screen.dart';
// import 'package:userapp/auth/sign_up_screen/verification_page.dart';
// import 'package:userapp/auth/u_auth.dart';
// import 'package:userapp/pet_color/hex_color.dart';

// import '../../styles/text_styles.dart';
// import 'email_page.dart';
// import 'password_page.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({
//     super.key,
//     required this.reloadInitApp,
//   });

//   final VoidCallback reloadInitApp;

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final PageController controller = PageController();

//   String? email;
//   String? password;
//   String? code;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HexColor("FFFF8F"),
//       body: Stack(
//         children: [
//           const Align(
//             alignment: Alignment(0, 0.89),
//             child: SizedBox(
//               height: 380,
//               child: RiveAnimation.asset(
//                 'assets/Animations/lottietest_05.riv',
//                 fit: BoxFit.cover,
//                 alignment: Alignment(0.65, 0),
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             physics: const ClampingScrollPhysics(),
//             child: SizedBox(
//               height: 100.h,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(28, 76, 28, 28),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: PageView(
//                         physics: const NeverScrollableScrollPhysics(),
//                         controller: controller,
//                         children: <Widget>[
//                           SignUpEmailPage(
//                             onNext: (useremail) {
//                               setState(() {
//                                 email = useremail;
//                               });
//                               controller.animateToPage(1,
//                                   duration: const Duration(milliseconds: 250),
//                                   curve: Curves.fastOutSlowIn);
//                             },
//                           ),
//                           SignUpPasswordPage(
//                             onNext: (userpassword) {
//                               setState(() {
//                                 password = userpassword;
//                               });
//                               controller.animateToPage(2,
//                                   duration: const Duration(milliseconds: 250),
//                                   curve: Curves.fastOutSlowIn);
//                             },
//                           ),
//                           //Sends Code on init Verification Page
//                           SignUpVerificationPage(
//                             useremail: email ?? "",
//                             onCodeCorrect: (code) {
//                               print(email.toString() +
//                                   password.toString() +
//                                   code);
//                               signUpUser(email!, password!, code)
//                                   .then((successFullSignUp) {
//                                 if (successFullSignUp) {
//                                   login(email!, password!, true).then(
//                                     (loginSuccessfull) {
//                                       if (loginSuccessfull) {
//                                         Navigator.of(context)
//                                             .popUntil((route) => route.isFirst);
//                                         widget.reloadInitApp.call();
//                                       } else {
//                                         print("error in SignUp Process");
//                                       }
//                                     },
//                                   );
//                                 }
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                     // Spacer(),
//                     SizedBox(height: 03.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Already a member? ",
//                           style: loginNotAMembner,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginScreen(
//                                   reloadInitApp: () => widget.reloadInitApp(),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             "Log In now",
//                             style: loginSignUp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

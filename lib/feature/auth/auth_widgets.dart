// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:userapp/feature/auth/u_auth.dart';
// import 'package:userapp/init_app.dart';
// import 'package:userapp/general/utils_general.dart';
// import '../../general/utils_theme/custom_colors.dart';

// class CustomBigButton extends StatelessWidget {
//   const CustomBigButton({
//     super.key,
//     this.onTap,
//     required this.label,
//   });

//   final void Function()? onTap;
//   final String label;

//   final double _borderRadius = 22;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Material(
//         borderRadius: BorderRadius.circular(_borderRadius),
//         elevation: 2,
//         child: Container(
//           width: double.infinity,
//           height: 60,
//           decoration: BoxDecoration(
//             color: getCustomColors(context).accent,
//             border: Border.all(
//               width: 1,
//               color: getCustomColors(context).lightBorder ?? Colors.transparent,
//               // strokeAlign: BorderSide.strokeAlignOutside,
//             ),
//             borderRadius: BorderRadius.circular(_borderRadius),
//             //The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12, 16, 24
//             // boxShadow: kElevationToShadow[4],
//           ),
//           child: Center(
//               child: Text(
//             label,
//             style: Theme.of(context)
//                 .textTheme
//                 .titleMedium
//                 ?.copyWith(color: Colors.white),
//           )),
//         ),
//       ),
//     );
//   }
// }

// class ContinueWithSocialMedia extends StatelessWidget {
//   const ContinueWithSocialMedia({
//     super.key,
//     // required this.reloadInitApp,
//   });

//   // final VoidCallback reloadInitApp;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Opacity(
//           opacity: 0.28,
//           child: Row(
//             children: [
//               const Expanded(child: Divider()),
//               SizedBox(width: 03.w),
//               Text(
//                 "continueWithSocials".tr(),
//                 style: Theme.of(context).textTheme.labelMedium,
//               ),
//               SizedBox(width: 03.w),
//               const Expanded(child: Divider()),
//             ],
//           ),
//         ),
//         SizedBox(height: 02.h),
//         Padding(
//           padding: const EdgeInsets.only(left: 36, right: 36),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   if (kIsWeb) {
//                     await signInWithGoogleWeb().then((value) {
//                       Navigator.of(context).popUntil((route) => route.isFirst);
//                       navigateReplacePerSlide(context, const InitApp());
//                     });
//                   } else {
//                     try {
//                       await signInWithGoogle(context: context).then((value) {
//                         Navigator.of(context)
//                             .popUntil((route) => route.isFirst);
//                         navigateReplacePerSlide(context, const InitApp());
//                       });
//                     } catch (e) {
//                       // showDialog(
//                       //   context: context,
//                       //   builder: (context) {
//                       //     return Dialog(
//                       //       child: Text(e.toString()),
//                       //     );
//                       //   },
//                       // );
//                     }
//                   }
//                 },
//                 child: const SocialMediaContainer(),
//               ),
//               const SocialMediaContainer(),
//               const SocialMediaContainer(),
//             ],
//           ),
//         ),
//         SizedBox(height: 03.h),
//       ],
//     );
//   }
// }

// class SocialMediaContainer extends StatelessWidget {
//   const SocialMediaContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(8),
//       elevation: 4,
//       child: Container(
//         height: 60,
//         width: 80,
//         decoration: BoxDecoration(
//           // color: Theme.of(context).primaryColor,
//           color: getCustomColors(context).surface,
//           border: Border.all(
//             width: 1,
//             color: getCustomColors(context).lightBorder ?? Colors.transparent,
//           ),
//           borderRadius: BorderRadius.circular(8),
//           // boxShadow: kElevationToShadow[4],
//         ),
//       ),
//     );
//   }
// }

//Chat

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auth/u_auth.dart';
import 'package:userapp/init_app.dart';
import 'package:userapp/general/utils_general.dart';
import '../../general/utils_theme/custom_colors.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({
    super.key,
    this.onTap,
    required this.label,
  });

  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(22),
        elevation: 2,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: getCustomColors(context).accent,
            border: Border.all(
              width: 1,
              color: getCustomColors(context).lightBorder ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class ContinueWithSocialMedia extends StatelessWidget {
  const ContinueWithSocialMedia({super.key});

  Future<void> _handleSignIn(
      BuildContext context, Future<void> Function() signInMethod) async {
    try {
      await signInMethod();
      Navigator.of(context).popUntil((route) => route.isFirst);
      navigateReplacePerSlide(context, const InitApp());
    } catch (e) {
      // Handle error (e.g., show a dialog or a snackbar)
      print("Error signing in: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: 0.28,
          child: Row(
            children: [
              const Expanded(child: Divider()),
              SizedBox(width: 3.w),
              Text(
                "continueWithSocials".tr(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(width: 3.w),
              const Expanded(child: Divider()),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _handleSignIn(
                  context,
                  kIsWeb
                      ? signInWithGoogleWeb
                      : () => signInWithGoogle(context: context),
                ),
                child: const SocialMediaContainer(),
              ),
              const SocialMediaContainer(),
              const SocialMediaContainer(),
            ],
          ),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({super.key});

  Future<void> _handleSignIn(
      BuildContext context, Future<void> Function() signInMethod) async {
    try {
      await signInMethod();
      Navigator.of(context).popUntil((route) => route.isFirst);
      navigateReplacePerSlide(context, const InitApp());
    } catch (e) {
      // Handle error (e.g., show a dialog or a snackbar)
      print("Error signing in: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: 0.28,
          child: Row(
            children: [
              const Expanded(child: Divider()),
              SizedBox(width: 3.w),
              Text(
                "continueWithSocials".tr(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(width: 3.w),
              const Expanded(child: Divider()),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: GestureDetector(
            onTap: () => _handleSignIn(
              context,
              kIsWeb
                  ? signInWithGoogleWeb
                  : () => signInWithGoogle(context: context),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: getCustomColors(context).surface,
                  border: Border.all(
                    width: 1,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        'assets/tmp/google.png',
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Google",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}

class SocialMediaContainer extends StatelessWidget {
  const SocialMediaContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: Container(
        height: 60,
        width: 80,
        decoration: BoxDecoration(
          color: getCustomColors(context).surface,
          border: Border.all(
            width: 1,
            color: getCustomColors(context).lightBorder ?? Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

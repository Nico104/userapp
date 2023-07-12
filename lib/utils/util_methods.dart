import 'package:flutter/material.dart';

void navigatePerSlide(BuildContext context, Widget naviagteTo,
    {int durationMilliseconds = 125, VoidCallback? callback}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => naviagteTo,
      transitionDuration: Duration(milliseconds: durationMilliseconds),
      reverseTransitionDuration: Duration(milliseconds: durationMilliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  ).then((value) {
    if (callback != null) {
      callback.call();
    }
  });
}

void navigateReplacePerSlide(BuildContext context, Widget naviagteTo,
    {int durationMilliseconds = 125, VoidCallback? callback}) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => naviagteTo,
      transitionDuration: Duration(milliseconds: durationMilliseconds),
      reverseTransitionDuration: Duration(milliseconds: durationMilliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  ).then((value) {
    if (callback != null) {
      callback.call();
    }
  });
}

///Checks if String is not null and not empty
bool isNotNullOrEmpty(String? string) {
  if (string == null) {
    return false;
  } else {
    if (string.isEmpty) {
      return false;
    }
  }
  return true;
}

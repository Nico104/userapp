import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: OnBoardingSlider(
          headerBackgroundColor: Theme.of(context).canvasColor,
          pageBackgroundColor: Theme.of(context).canvasColor,
          finishButtonText: 'Lets go!',
          finishButtonStyle: FinishButtonStyle(
            backgroundColor: getCustomColors(context).accent ?? Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          onFinish: () => Navigator.pop(context),
          skipTextButton: Text(
            'Skip',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          background: [
            Image.asset('assets/tmp/onboarding1.png'),
            Image.asset('assets/tmp/onboarding1.png'),
            Image.asset('assets/tmp/onboarding1.png'),
            Image.asset('assets/tmp/onboarding1.png'),
          ],
          centerBackground: true,
          totalPage: 4,
          speed: 1.8,
          pageBodies: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    'Create Pet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Create your Pets digital Profile in order to make your Tailfur Tags accessable',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    'Add Tag',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Add your Tailfur Tag to your Pet',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    'Enjoy',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Enjoy your Tailfur Tag and having all your Pets information with him/her all the time while managing it all easily right here',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Create your account in just a few clicks',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> setSeenOnboarding(bool val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('seenOnboarding', val);
}

Future<bool> getSeenOnboarding() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('seenOnboarding') ?? false;
}

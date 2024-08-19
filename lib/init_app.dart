import 'dart:io' show Platform;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/sign_up_screen/sign_up_screen.dart';
import 'package:userapp/feature/settings/setting_screens/how_to/how_to_dialog.dart';
import 'package:userapp/general/utils_general.dart';
import 'feature/auth/login_screen.dart';
import 'feature/auth/u_auth.dart';
import 'feature/onboarding/onboarding_page.dart';
import 'feature/pets/pets_loading.dart';
import 'general/widgets/future_error_widget.dart';
import 'general/widgets/loading_indicator.dart';

class InitApp extends StatefulWidget {
  const InitApp({
    super.key,
  });

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  //Messaging
  late FirebaseMessaging messaging;

  // void reloadInitApp() {
  //   print("reload Init App");
  //   //If not loged in - after login this function gets called and shoudl initialize the messagin correctly
  //   _initMessaging();
  //   setState(() {});
  // }

  //Message only working when app is closed
  //When app is open:
  //https://stackoverflow.com/questions/62688519/flutter-push-notification-is-working-only-when-app-is-in-background
  void _initMessaging() async {
    bool userIsAuthenticated = await isAuthenticated();

    if (!kIsWeb) {
      if (userIsAuthenticated && (Platform.isAndroid || Platform.isIOS)) {
        //https://firebase.google.com/docs/cloud-messaging/flutter/client
        messaging = FirebaseMessaging.instance;
        messaging.getToken().then((fcmToken) {
          print("Token: $fcmToken\n\n\n");
          if (fcmToken != null) {
            connectDeviceTokenToUser(fcmToken);
          }
        });
        FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
          print("Token refreshed: $fcmToken\n\n\n");
          connectDeviceTokenToUser(fcmToken);
        }).onError((err) {
          // Error getting token.
        });
        _initForegroundMessaging();
      }
    }
  }

  void _initForegroundMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //Normal Push Notification Clicked
      print('\n\n');
      print('Message data: ' + message.data['type']);
      print('\n\n');
      // if data[type] == scannavigate to scans usw
      // navigatePerSlide(context, Settings());
    });
  }

  /*
  void _initFireBaseAuthIdToken() {
    //     Events are fired when the following occurs:

    // Right after the listener has been registered.
    // When a user is signed in.
    // When the current user is signed out.
    // When there is a change in the current user's token.

    firebaseAuth.FirebaseAuth.instance
        .idTokenChanges()
        .listen((firebaseAuth.User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        user.getIdToken().then((String token) async {
          print('The user ID token is' + token);
        });
      }
    });
  }
  */

  @override
  void initState() {
    super.initState();

    // _initFireBaseAuthIdToken();

    //Messaging
    _initMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //TODO Figure out what up wiht the http Parameter
      future: Future.wait([
        isAuthenticated(),
        getLoggedInOnce(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if ((snapshot.data[0] as bool)) {
            //TODO refresh Token...just saying
            return const PetsLoading();
          } else if ((snapshot.data[1] as bool)) {
            return const LoginScreen();
          } else {
            return const SignUpScreen();
          }
        } else if (snapshot.hasError) {
          print("Error" + snapshot.error.toString());
          WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FutureErrorWidget(),
                ),
              ).then((value) => setState(
                    () {},
                  )));
          return const SizedBox.shrink();
        } else {
          //Loading
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CustomLoadingIndicatior(),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

// class AuthWebWrapper extends StatelessWidget {
//   const AuthWebWrapper({super.key, required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       child: Center(
//         child: Material(
//           elevation: 4,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: SizedBox(
//               width: webwidth,
//               child: child,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeWebWrapper extends StatelessWidget {
//   const HomeWebWrapper({super.key, required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

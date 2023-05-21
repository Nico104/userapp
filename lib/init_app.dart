import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:userapp/auth/sign_up_screen/sign_up_screen.dart';
import 'auth/login_screen.dart';
import 'auth/u_auth.dart';
import 'pets/pets_loading.dart';

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

  void reloadInitApp() {
    print("reload Init App");
    //If not loged in - after login this function gets called and shoudl initialize the messagin correctly
    _initMessagin();
    setState(() {});
  }

  //Message only working when app is closed
  //When app is open:
  //https://stackoverflow.com/questions/62688519/flutter-push-notification-is-working-only-when-app-is-in-background
  void _initMessagin() async {
    bool userIsAuthenticated = await isAuthenticated();

    if (!kIsWeb) {
      if (userIsAuthenticated && (Platform.isAndroid || Platform.isIOS)) {
        //https://firebase.google.com/docs/cloud-messaging/flutter/client
        messaging = FirebaseMessaging.instance;
        messaging.getToken().then((fcmToken) {
          print("Token: " + fcmToken.toString() + "\n\n\n");
          if (fcmToken != null) {
            connectDeviceTokenToUser(fcmToken);
          }
        });
        FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
          print("Token refreshed: " + fcmToken + "\n\n\n");
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
              title: Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
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

  @override
  void initState() {
    super.initState();

    //Messaging
    _initMessagin();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginWithSavedCredentials().then((value) {
        if (value) {
          reloadInitApp.call();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //TODO Figure out what up wiht the http Parameter
      future: Future.wait([
        isAuthenticated(),
        getToken(),
        getLoggedInOnce(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if ((snapshot.data[0] as bool)) {
            //TODO refresh Token...just saying
            return const PetsLoading();
          } else if ((snapshot.data[2] as bool)) {
            return LoginScreen(
              reloadInitApp: () => reloadInitApp(),
            );
          } else {
            return SignUpScreen(
              reloadInitApp: () => reloadInitApp(),
            );
          }
        } else if (snapshot.hasError) {
          print(snapshot);
          //Error
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Init App Error: ${snapshot.error}'),
                ),
              ],
            ),
          );
        } else {
          //Loading
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting User Data...'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

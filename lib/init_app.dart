import 'package:flutter/material.dart';
import 'package:userapp/auth/sign_up_screen.dart';
import 'package:userapp/home.dart';
import 'auth/login_screen.dart';
import 'auth/u_auth.dart';

class InitApp extends StatefulWidget {
  const InitApp({
    super.key,
  });

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  void reloadInitApp() {
    print("reload Init App");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
            return const HomeScreen();
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

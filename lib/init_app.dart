import 'package:flutter/material.dart';
import 'package:userapp/home.dart';
import 'auth/login_screen.dart';
import 'auth/u_auth.dart';
import 'package:http/http.dart' as http;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //TODO Figure out what up wiht the http Parameter
        future: isAuthenticated(http.Client()),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              //TODO refresh Token...just saying
              return const HomeScreen();
            } else {
              return LoginScreen(
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
      ),
    );
  }
}

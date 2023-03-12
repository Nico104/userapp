import 'package:flutter/material.dart';
import 'package:userapp/init_app.dart';

import '../auth/u_auth.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            logout().then(
              (value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const InitApp()),
                    (route) => false);
              },
            );
          },
          child: Container(
            color: Colors.blue,
            width: 100,
            height: 60,
            child: const Text("Logout"),
          ),
        ),
      ),
    );
  }
}

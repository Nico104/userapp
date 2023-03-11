import 'package:flutter/material.dart';
import 'package:userapp/auth/u_auth.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.reloadInitApp});

  final VoidCallback reloadInitApp;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Login"),
        TextFormField(
          controller: email,
          cursorColor: Colors.black.withOpacity(0.74),
          decoration: InputDecoration(
            hintText: "Email",
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
          ),
        ),
        TextFormField(
          controller: password,
          cursorColor: Colors.black.withOpacity(0.74),
          decoration: InputDecoration(
            hintText: "Password",
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () async {
            bool log = await login(email.text, password.text, http.Client());
            if (log) {
              widget.reloadInitApp.call();
              Navigator.pop(context);
            }
          },
          child: Text("Login"),
        ),
      ],
    );
  }
}

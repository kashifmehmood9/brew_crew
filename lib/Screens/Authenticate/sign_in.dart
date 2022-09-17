import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Services/AuthService.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign in to brew crew"),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: ElevatedButton.icon(
                onPressed: () async {
                  AppUser result = await _authService.signInAnonymously();
                  print("User id is ${result.uid}");
                },
                icon: Icon(Icons.login),
                label: Text("Sign in")),
          ),
        ),
      ),
    );
  }
}

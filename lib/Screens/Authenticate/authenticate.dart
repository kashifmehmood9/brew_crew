import 'package:brew_crew/Screens/Authenticate/register.dart';
import 'package:brew_crew/Screens/Authenticate/sign_in.dart';
import 'package:brew_crew/Services/AuthService.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  var showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(
        child: SignIn(toggleView: toggleView),
      );
    }

    return Container(
      child: Register(toggleView: toggleView),
    );
  }
}

import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Screens/Authenticate/authenticate.dart';
import 'package:brew_crew/Screens/Home/home.dart';
import 'package:brew_crew/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    print("Wrapper---- $user");

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

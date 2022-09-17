import 'package:brew_crew/Services/AuthService.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Brew crew"),
        elevation: 0.0,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                _authService.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"))
        ],
      ),
    );
  }
}

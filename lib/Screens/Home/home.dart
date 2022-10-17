import 'package:brew_crew/Models/User.dart';

import 'brew.dart';
import 'package:brew_crew/Services/AuthService.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(userID: user.uid).brews,
      catchError: (_, err) {
        print("Getting errors $err ");
        return [];
      },
      initialData: [],
      child: Scaffold(
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
                label: Text("Logout")),
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/coffee_bg.png"),
                    fit: BoxFit.cover)),
            child: const BrewList()),
      ),
    );
  }
}

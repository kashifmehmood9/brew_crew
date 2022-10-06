import 'brew.dart';
import 'settings_form.dart';
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
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
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
            ElevatedButton.icon(
                onPressed: () => _createBottomSheet(context),
                icon: Icon(Icons.settings),
                label: Text("settings"))
          ],
        ),
        body: BrewList(),
      ),
    );
  }

  void _createBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SettingsForm(),
          );
        });
  }
}

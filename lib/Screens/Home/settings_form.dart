import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Shared/Constants.dart';
import 'package:brew_crew/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  late String _name;
  String? _currentSugars;

  int _strength = 100;
  late UserData userData;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(userID: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData && _currentSugars == null) {
            userData = snapshot.data as UserData;

            _name = userData.name;
            _currentSugars = userData.sugars.toString();
            _strength = userData.strength;
          }
          return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Update your settings",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: _name,
                    decoration:
                        textInputDecoration.copyWith(hintText: "Enter name"),
                    validator: (val) =>
                        (val?.isEmpty ?? false) ? "Please enter a name" : null,
                    onChanged: (val) {
                      _name = val;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: "Sugars"),
                    value: _currentSugars,
                    items: sugars
                        .map((String item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentSugars = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Slider(
                      min: 100,
                      max: 800,
                      divisions: 7,
                      activeColor: Colors.brown[_strength],
                      inactiveColor: Colors.brown[_strength],
                      onChanged: (value) {
                        setState(() {
                          _strength = value.round();
                        });
                      },
                      value: _strength.toDouble()),
                  ElevatedButton.icon(
                      onPressed: () async {
                        if ((_formKey.currentState?.validate() ?? false) &&
                            (_currentSugars != null)) {
                          await DatabaseService(userID: user.uid)
                              .updateUserData(int.parse(_currentSugars!),
                                  _name!, _strength!);
                          Navigator.pop(context);
                        } else {
                          _formKey.currentState?.validate();
                        }
                      },
                      icon: const Icon(Icons.update),
                      label: const Text("Update"))
                ],
              ));
        });
  }
}

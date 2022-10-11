import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Shared/Constants.dart';
import 'package:brew_crew/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  late String _name, _currentSugars;
  late String _strength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(userID: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data as UserData;
            // snapshot.
            _name = userData.name;
            _currentSugars = userData.sugars;
            _strength = userData.strength;
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
                      validator: (val) => (val?.isEmpty ?? false)
                          ? "Please enter a name"
                          : null,
                      onChanged: (val) => setState(() {
                        _name = val;
                      }),
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
                              DropdownMenuItem(child: Text(item), value: item))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _currentSugars = value ?? userData.sugars;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Slider(
                        min: 100,
                        max: 800,
                        divisions: 8,
                        activeColor: Colors.brown,
                        inactiveColor: Colors.brown,
                        value: double.parse(_strength ?? "0"),
                        onChanged: (value) {
                          setState(() {
                            _strength = value.toString();
                          });
                        }),
                    ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await DatabaseService(userID: user.uid)
                                .updateUserData(
                                    _currentSugars, _name, _strength);
                          }
                        },
                        icon: const Icon(Icons.update),
                        label: const Text("Update"))
                  ],
                ));
          } else {
            DatabaseService(userID: user.uid)
                .updateUserData("0", "kashif", "100");
            return const Loading();
          }
        });
  }
}

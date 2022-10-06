import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Shared/Constants.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _name, _currentSugars;
  String _strength = '100';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Update your settings",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: "Enter name"),
              validator: (val) =>
                  (val?.isEmpty ?? false) ? "Please enter a name" : null,
              onChanged: (val) => setState(() {
                _name = val;
              }),
            ),
            DropdownButtonFormField(
              decoration: textInputDecoration,
              value: _currentSugars ?? '0',
              items: sugars
                  .map((String item) =>
                      DropdownMenuItem(child: Text(item), value: item))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _currentSugars = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Slider(
                min: 100,
                max: 800,
                divisions: 8,
                activeColor: Colors.brown,
                inactiveColor: Colors.brown,
                value: double.parse(_strength),
                onChanged: (value) {
                  setState(() {
                    _strength = value.toString();
                  });
                }),
            ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    DatabaseService().updateUserData(
                        _currentSugars ?? "0", _name ?? "", _strength);
                  }

                  print("name: $_name");
                  print("sugars: $_currentSugars");
                  print("name: $_strength");
                },
                icon: Icon(Icons.update),
                label: Text("Update"))
          ],
        ));
  }
}

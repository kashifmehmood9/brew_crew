import 'package:brew_crew/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/Services/AuthService.dart';
import 'package:brew_crew/Shared/Constants.dart';
import 'package:brew_crew/Shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In")),
        ],
        title: const Text("Sign up to brew crew"),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Enter email'),
                    validator: (value) {
                      return (value?.isEmpty ?? false)
                          ? "enter correct email"
                          : null;
                    },
                    onChanged: (val) {
                      _email = val;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Password'),
                    obscureText: true,
                    validator: (value) {
                      return (value?.length ?? 0) < 6
                          ? "enter 6+ chars long"
                          : null;
                    },
                    onChanged: (val) {
                      _password = val;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            loading = true;
                          });
                          dynamic user = await _authService
                              .registerWithEmailPassword(_email, _password);

                          if (user is RegistrationError) {
                            setState(() {
                              _error = user.localizedDescription;
                              loading = false;
                            });
                          }
                        }
                      },
                      icon: loading
                          ? Center(child: Loading())
                          : Icon(Icons.login),
                      label: loading
                          ? Text('Loading...')
                          : Text(
                              'Sign up',
                              style: TextStyle(color: Colors.white),
                            )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _error,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

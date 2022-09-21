import 'package:brew_crew/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/Services/AuthService.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        dynamic user = await _authService
                            .registerWithEmailPassword(_email, _password);

                        if (user is RegistrationError) {
                          setState(() => _error = user.localizedDescription);
                        }
                      }
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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

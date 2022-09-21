import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/Shared/Constants.dart';

class SignIn extends StatefulWidget {
  Function? toggleView;

  SignIn({this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    final _formKey = GlobalKey<FormState>();

    String _email = "";
    String _password = "";
    String _error = "";

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Sign in to brew crew"),
        elevation: 0.0,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                widget.toggleView?.call();
              },
              icon: Icon(Icons.app_registration),
              label: Text("Register")),
        ],
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
                        textInputDecoration.copyWith(hintText: 'enter email'),
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        dynamic user = await _authService
                            .signInWithEmailPassword(_email, _password);

                        if (user is LoginError) {
                          setState(() => _error = user.localizedDescription);
                        }
                      }
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
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

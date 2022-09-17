import 'package:brew_crew/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser _userFromFirebase(User? user) {
    return user != null ? AppUser(uid: user.uid) : AppUser(uid: "-");
  }

  Stream<AppUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }
  //anonymous sign in

  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      // notifyListeners();
      return _userFromFirebase(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
// sign in with email and password

  //register with email and passord

  //signout

  Future signOut() async {
    try {
      print("Signing out...");
      await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}

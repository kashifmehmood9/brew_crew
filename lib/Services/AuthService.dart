import 'package:brew_crew/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class AuthService with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebase(User? user) {
    print("casting user ${user?.uid}");
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    notifyListeners();
    Stream<AppUser?> user = _auth.authStateChanges().map(_userFromFirebase);
    print("User state changed --- $user");
    return user;
  }
  //anonymous sign in

  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
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
      print("Signing out complete");
      print("User is -- $user");
    } catch (e) {
      print(e);
      return null;
    }
  }
}

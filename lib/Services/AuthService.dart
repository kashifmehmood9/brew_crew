import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class AuthService with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebase(User? user) {
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
  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(result.user);
    } catch (e) {
      return LoginError(localizedDescription: e.toString());
    }
  }

  //register with email and password

  Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await DatabaseService(userID: result.user?.uid ?? "")
          .updateUserData('0', "kashif", "strength");
      return _userFromFirebase(result.user);
    } catch (e) {
      return RegistrationError(localizedDescription: e.toString());
    }
  }
  //signout

  Future signOut() async {
    try {
      print("Signing out...");
      await _auth.signOut();
      print("Signing out complete");
    } catch (e) {
      print(e);
      return null;
    }
  }
}

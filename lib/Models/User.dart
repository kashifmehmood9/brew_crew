class AppUser {
  final String uid;

  AppUser({required this.uid});
}

class RegistrationError extends Error {
  String localizedDescription;

  RegistrationError({required this.localizedDescription});
}

class LoginError extends Error {
  String localizedDescription;

  LoginError({required this.localizedDescription});
}

class UserData {
  final String uid;
  final String name;
  final int sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}

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

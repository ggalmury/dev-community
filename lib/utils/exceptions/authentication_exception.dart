class AuthenticationException implements Exception {
  final String? message;

  AuthenticationException({this.message});

  @override
  String toString() => message ?? "AuthenticationException";
}

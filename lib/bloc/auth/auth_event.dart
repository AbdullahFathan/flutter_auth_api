part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;
  Login({
    required this.email,
    required this.password,
  });
}

// Cek the user has already login or not
class IsHasLogin extends AuthEvent {}

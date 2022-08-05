part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthEror extends AuthState {
  final String text;

  AuthEror(this.text);
}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthenticatedEror extends AuthState {}

class AuthenticatedLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  RegisterModel post;
  RegisterSuccess(
    this.post,
  );
}

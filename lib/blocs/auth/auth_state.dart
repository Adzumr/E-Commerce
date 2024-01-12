part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final User? user;

  LoginSuccess({
    required this.user,
  });
}

final class SignupSuccess extends AuthState {
  final User? user;

  SignupSuccess({
    required this.user,
  });
}

final class LoginFailure extends AuthState {
  final String? error;

  LoginFailure({
    required this.error,
  });
}

final class SignupFailure extends AuthState {
  final String? error;

  SignupFailure({
    required this.error,
  });
}

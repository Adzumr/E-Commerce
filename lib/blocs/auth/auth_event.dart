part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String? emailAddress;
  final String? password;

  LoginEvent({
    required this.emailAddress,
    required this.password,
  });
}

final class SignupEvent extends AuthEvent {
  final String? emailAddress;
  final String? password;

  SignupEvent({
    required this.emailAddress,
    required this.password,
  });
}

final class UpdateProfileEvent extends AuthEvent {
  final String? emailAddress;
  final String? password;
  final String? profilePicture;

  UpdateProfileEvent({
    required this.emailAddress,
    required this.password,
    this.profilePicture,
  });
}

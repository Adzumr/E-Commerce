import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository? authRepository;
  AuthBloc({
    this.authRepository,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository!.login(
          emailAddress: event.emailAddress,
          password: event.password,
        );
        emit(
          LoginSuccess(user: user),
        );
      } catch (e) {
        emit(
          LoginFailure(
            error: "$e",
          ),
        );
      }
    });
    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository!.signup(
          emailAddress: event.emailAddress,
          password: event.password,
        );
        emit(
          SignupSuccess(user: user),
        );
      } catch (e) {
        emit(
          SignupFailure(
            error: "$e",
          ),
        );
      }
    });
  }
}

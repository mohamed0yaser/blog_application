import 'package:blog_application/features/auth/domain/entities/user.dart';
import 'package:blog_application/features/auth/domain/usecases/user_login.dart';
import 'package:blog_application/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
  _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignup);
    on<AuthLogin>(_onAuthLogin);
    
  }

  void _onAuthSignup(AuthSignUp event, Emitter emit) async {
    emit(AuthLoading());
    final results = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    results.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
    print(results);
  }

  void _onAuthLogin(AuthLogin event, Emitter emit) async {
    emit(AuthLoading());
    final results = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    results.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
    print(results);
  }
}

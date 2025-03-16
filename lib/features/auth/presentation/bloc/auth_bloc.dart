import 'package:blog_application/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/core/usecase/usecase.dart';
import 'package:blog_application/core/common/entities/user.dart';
import 'package:blog_application/features/auth/domain/usecases/current_user.dart';
import 'package:blog_application/features/auth/domain/usecases/user_login.dart';
import 'package:blog_application/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
          on<AuthEvent>((_, emit) {emit(AuthLoading());});
          on<AuthSignUp>(_onAuthSignup);
          on<AuthLogin>(_onAuthLogin);
          on<AuthCurrentUserLoggedIn>(_onAuthCurrentUserLoggedIn);
          
  }

  void _onAuthCurrentUserLoggedIn(AuthCurrentUserLoggedIn event, Emitter<AuthState> emit) async {
    final results = await _currentUser(NoParams());
    results.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignup(AuthSignUp event, Emitter<AuthState> emit) async {

    final results = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    results.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
 
    final results = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    results.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess (user, emit),
    );
  }
  void _emitAuthSuccess (User user, Emitter<AuthState> emit){
    emit(AuthSuccess(user: user));
    _appUserCubit.updateUser(user);
  }
}

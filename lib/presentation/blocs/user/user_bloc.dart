import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/get_local_user_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/login_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/logout_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/register_use_case.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final GetLocalUserUseCase _getLocalUserUseCase;
  final LogoutUseCase _logoutUseCase;

  UserBloc(
    this._registerUseCase,
    this._loginUseCase,
    this._getLocalUserUseCase,
    this._logoutUseCase,
  ) : super(UserInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<LoginUserEvent>(_onLoginUser);
    on<CheckUserEvent>(_onCheckUser);
    on<LogoutUserEvent>(_onLogoutUser);
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final result = await _registerUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  Future<void> _onLoginUser(
    LoginUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final result = await _loginUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  Future<void> _onCheckUser(
    CheckUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final result = await _getLocalUserUseCase(NoParams());
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  Future<void> _onLogoutUser(
    LogoutUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await _logoutUseCase(NoParams());
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}

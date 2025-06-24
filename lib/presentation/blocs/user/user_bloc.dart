import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/get_user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/login_user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/register_user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/update_user.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final RegisterUser registerUser;
  final LoginUser loginUser;
  final GetUser getUser;
  final UpdateUser updateUser;

  UserBloc({
    required this.registerUser,
    required this.loginUser,
    required this.getUser,
    required this.updateUser,
  }) : super(UserInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<LoginUserEvent>(_onLoginUser);
    on<GetUserEvent>(_onGetUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<LogoutUserEvent>(_onLogoutUser);
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await registerUser(event.user);
      emit(UserAuthenticated(user));
    } catch (e) {
      emit(UserError('Failed to register user'));
    }
  }

  Future<void> _onLoginUser(
    LoginUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await loginUser(event.email, event.password);
      emit(UserAuthenticated(user));
    } catch (e) {
      emit(UserError('Invalid email or password'));
    }
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await getUser(event.userId);
      if (user != null) {
        emit(UserAuthenticated(user));
      } else {
        emit(UserUnauthenticated());
      }
    } catch (e) {
      emit(UserError('Failed to fetch user'));
    }
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await updateUser(event.user);
      emit(UserAuthenticated(user));
    } catch (e) {
      emit(UserError('Failed to update user'));
    }
  }

  Future<void> _onLogoutUser(
    LogoutUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserUnauthenticated());
  }
}

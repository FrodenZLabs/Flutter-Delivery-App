part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoginUserEvent extends UserEvent {
  final LoginParams params;
  LoginUserEvent(this.params);
}

class RegisterUserEvent extends UserEvent {
  final RegisterParams params;
  RegisterUserEvent(this.params);
}

class LogoutUserEvent extends UserEvent {}

class CheckUserEvent extends UserEvent {}

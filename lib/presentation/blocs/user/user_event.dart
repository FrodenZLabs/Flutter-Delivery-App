part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends UserEvent {
  final User user;
  const RegisterUserEvent(this.user);

  @override
  List<Object> get props => [user];
}

class LoginUserEvent extends UserEvent {
  final String email;
  final String password;

  const LoginUserEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class GetUserEvent extends UserEvent {
  final String userId;

  const GetUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateUserEvent extends UserEvent {
  final User user;

  const UpdateUserEvent(this.user);

  @override
  List<Object> get props => [user];
}

class LogoutUserEvent extends UserEvent {}

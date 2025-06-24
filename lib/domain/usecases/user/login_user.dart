import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<User> call(String email, String password) =>
      repository.loginUser(email, password);
}

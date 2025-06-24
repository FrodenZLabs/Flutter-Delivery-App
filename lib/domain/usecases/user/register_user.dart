import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<User> call(User user) => repository.registerUser(user);
}

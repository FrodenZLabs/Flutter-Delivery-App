import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase implements UseCase<User, LoginParams> {
  final UserRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.loginUser(params);
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}

import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RegisterUseCase implements UseCase<User, RegisterParams> {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.registerUser(params);
  }
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}

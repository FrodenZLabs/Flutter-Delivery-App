import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLocalUserUseCase implements UseCase<User, NoParams> {
  final UserRepository repository;

  GetLocalUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getLocalUser();
  }
}

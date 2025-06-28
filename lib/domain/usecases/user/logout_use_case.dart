import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase implements UseCase<NoParams, NoParams> {
  final UserRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.logoutUser();
  }
}

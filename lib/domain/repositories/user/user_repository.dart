import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/login_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/register_use_case.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> registerUser(RegisterParams params);
  Future<Either<Failure, User>> loginUser(LoginParams params);
  Future<Either<Failure, NoParams>> logoutUser();
  Future<Either<Failure, User>> getLocalUser();
}

import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/network/network_info.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:flutter_delivery_app/domain/usecases/user/login_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/register_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(this.remote, this.local, this.networkInfo);

  @override
  Future<Either<Failure, User>> getLocalUser() async {
    try {
      final user = await local.getUser();
      return Right(user);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginUser(LoginParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final remoteResponse = await remote.loginUser(params);
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(RegisterParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final remoteResponse = await remote.registerUser(params);
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> logoutUser() async {
    try {
      await local.clearCache();
      return Right(NoParams());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }
}

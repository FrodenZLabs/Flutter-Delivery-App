import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/network/network_info.dart';
import 'package:flutter_delivery_app/data/data_sources/local/schedule_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/schedule_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remote;
  final ScheduleLocalDataSource local;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  ScheduleRepositoryImpl(
    this.remote,
    this.local,
    this.networkInfo,
    this.userLocalDataSource,
  );

  @override
  Future<Either<Failure, Schedule>> bookSchedule(ScheduleModel params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final result = await remote.bookSchedule(params, token);
      await local.updateSchedule(params);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Schedule>> updateSchedule(ScheduleModel params) {
    // TODO: implement updateSchedule
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Schedule>>> getSchedulesByUser(
    ScheduleModel params,
  ) async {
    final token = await userLocalDataSource.getToken();
    final userId = await userLocalDataSource.getUserId();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final remoteServices = await remote.getSchedulesInfo(
        params,
        userId,
        token,
      );
      local.cacheSchedule(remoteServices);
      return Right(remoteServices);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Schedule>>> getLocalSchedulesByUser() async {
    try {
      final userId = await userLocalDataSource.getUserId();

      if (userId.isEmpty) {
        return Left(AuthenticationFailure());
      }

      final localSchedules = await local.getSchedulesByUser(userId);
      return Right(localSchedules);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
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
    debugPrint('===== getSchedulesByUser START =====');
    debugPrint('Params: ${params.toJson()}');

    debugPrint('Network connected: ${networkInfo.isConnected}');
    if (!await networkInfo.isConnected) {
      debugPrint('Returning NetworkFailure');
      return Left(NetworkFailure());
    }

    final token = await userLocalDataSource.getToken();
    final userId = await userLocalDataSource.getUserId();
    debugPrint('Token exists: ${token.isNotEmpty}');
    debugPrint('User ID: $userId');
    if (token.isEmpty) {
      debugPrint('Returning AuthenticationFailure');
      return Left(AuthenticationFailure());
    }

    try {
      debugPrint('Calling remote.getSchedulesInfo...');
      final remoteServices = await remote.getSchedulesInfo(
        params,
        userId,
        token,
      );
      debugPrint('Received ${remoteServices.length} schedules from remote');
      debugPrint(
        'First schedule (if any): ${remoteServices.isNotEmpty ? remoteServices.first.toJson() : "N/A"}',
      );
      debugPrint('Caching schedules locally...');
      local.cacheSchedule(remoteServices);
      debugPrint('Caching completed');
      debugPrint('Returning Right with ${remoteServices.length} schedules');
      return Right(remoteServices);
    } on ServerException catch (e) {
      debugPrint('ServerException caught:');
      debugPrint('- Type: ${e.runtimeType}');
      debugPrint('- Message: ${e.toString()}');
      return Left(ServerFailure());
    }
  }
}

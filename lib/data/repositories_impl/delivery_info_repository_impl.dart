import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/network/network_info.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeliveryInfoRepository)
class DeliveryInfoRepositoryImpl implements DeliveryInfoRepository {
  final DeliveryInfoRemoteDataSource remote;
  final DeliveryInfoLocalDataSource local;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  DeliveryInfoRepositoryImpl(
    this.remote,
    this.local,
    this.networkInfo,
    this.userLocalDataSource,
  );

  @override
  Future<Either<Failure, DeliveryInfo>> addDeliveryInfo(
    DeliveryInfoModel params,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final result = await remote.addDeliveryInfo(params, token);
      await local.updateDeliveryInfo(params);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> deleteLocalDeliveryInfo() async {
    try {
      await local.clearDeliveryInfo();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> editDeliveryInfo(
    DeliveryInfoModel params,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final result = await remote.editDeliveryInfo(params, token);
      await local.updateDeliveryInfo(result);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<DeliveryInfo>>> getLocalDeliveryInfo() async {
    try {
      final result = await local.getDeliveryInfo();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<DeliveryInfo>>> getRemoteDeliveryInfo() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final String token = await userLocalDataSource.getToken();
      final result = await remote.getDeliveryInfo(token);
      await local.saveDeliveryInfo(result);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> getSelectedDeliveryInfo() async {
    try {
      final result = await local.getSelectedDeliveryInfo();
      return Right(result!);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> selectDeliveryInfo(
    DeliveryInfo params,
  ) async {
    try {
      await local.updateSelectedDeliveryInfo(
        DeliveryInfoModel.fromEntity(params),
      );
      return Right(params);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}

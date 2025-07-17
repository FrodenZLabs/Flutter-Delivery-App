import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/network/network_info.dart';
import 'package:flutter_delivery_app/data/data_sources/local/service_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/service_remote_data_source.dart';
import 'package:flutter_delivery_app/domain/entities/service/service_response.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ServiceRepository)
class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;
  final ServiceLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ServiceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ServiceResponse>> getRemoteServices(
    FilterServiceParams params,
  ) async {
    try {
      final remoteServices = await remoteDataSource.getServices(params);
      localDataSource.cacheServices(remoteServices);
      return Right(remoteServices);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ServiceResponse>> getLocalServices() async {
    try {
      final localServices = await localDataSource.getCachedServices();
      return Right(localServices);
    } on ServerException {
      return Left(CacheFailure());
    }
  }
}

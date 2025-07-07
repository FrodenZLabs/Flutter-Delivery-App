import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/network/network_info.dart';
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/rating_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/rating/rating_response_model.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/repositories/rating/rating_repository.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RatingRepository)
class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource remote;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  RatingRepositoryImpl(this.remote, this.networkInfo, this.userLocalDataSource);

  @override
  Future<Either<Failure, Rating>> addRating(RatingParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final remoteServices = await remote.addRating(params, token);
      return Right(remoteServices);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RatingCheckResponseModel>> checkRating(
    String scheduleId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final remoteServices = await remote.checkRating(scheduleId, token);
      return Right(remoteServices);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }
}

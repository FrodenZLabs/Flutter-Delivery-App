import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/data/models/rating/rating_response_model.dart';
import 'package:flutter_delivery_app/domain/repositories/rating/rating_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckRatingUseCase implements UseCase<RatingCheckResponseModel, String> {
  final RatingRepository repository;

  CheckRatingUseCase(this.repository);

  @override
  Future<Either<Failure, RatingCheckResponseModel>> call(
    String scheduleId,
  ) async {
    debugPrint("UseCase called with: $scheduleId");
    try {
      final result = await repository.checkRating(scheduleId);
      debugPrint("UseCase result: $result");
      return result;
    } catch (e) {
      debugPrint("UseCase error: $e");
      return Left(ServerFailure());
    }
  }
}

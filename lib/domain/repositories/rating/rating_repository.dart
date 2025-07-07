import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/data/models/rating/rating_response_model.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating_use_case.dart';

abstract class RatingRepository {
  Future<Either<Failure, Rating>> addRating(RatingParams params);
  Future<Either<Failure, RatingCheckResponseModel>> checkRating(
    String scheduleId,
  );
}

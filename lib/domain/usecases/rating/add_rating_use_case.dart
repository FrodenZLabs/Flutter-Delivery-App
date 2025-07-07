import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/repositories/rating/rating_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddRatingUseCase implements UseCase<Rating, RatingParams> {
  final RatingRepository repository;
  AddRatingUseCase(this.repository);

  @override
  Future<Either<Failure, Rating>> call(RatingParams params) async {
    return await repository.addRating(params);
  }
}

class RatingParams {
  final String scheduleId;
  final int rating;
  final String comment;

  RatingParams({
    required this.scheduleId,
    required this.rating,
    required this.comment,
  });
}

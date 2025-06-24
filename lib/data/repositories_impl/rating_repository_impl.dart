import 'package:flutter_delivery_app/data/data_sources/remote/rating_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/rating/rating_model.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/repositories/rating/rating_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RatingRepository)
class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource remoteDataSource;

  RatingRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addRating(Rating rating) async {
    final model = RatingModel(
      id: rating.id,
      userId: rating.userId,
      driverId: rating.driverId,
      comment: rating.comment,
      ratingLevel: rating.ratingLevel,
      tip: rating.tip,
    );
    await remoteDataSource.addRating(model);
  }

  @override
  Future<List<Rating>> getRatingsByUser(String userId) async {
    final models = await remoteDataSource.getRatingsByUser(userId);
    return models;
  }
}

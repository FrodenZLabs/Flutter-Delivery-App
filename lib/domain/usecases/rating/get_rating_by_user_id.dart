import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/repositories/rating/rating_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRatingsByUser {
  final RatingRepository repository;

  GetRatingsByUser(this.repository);

  Future<List<Rating>> call(String userId) async {
    return await repository.getRatingsByUser(userId);
  }
}

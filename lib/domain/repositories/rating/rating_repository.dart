import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';

abstract class RatingRepository {
  Future<void> addRating(Rating rating);
  Future<List<Rating>> getRatingsByUser(String userId);
}

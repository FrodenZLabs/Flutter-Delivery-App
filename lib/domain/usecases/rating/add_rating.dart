import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/repositories/rating/rating_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddRating {
  final RatingRepository repository;

  AddRating(this.repository);

  Future<void> call(Rating rating) async {
    await repository.addRating(rating);
  }
}

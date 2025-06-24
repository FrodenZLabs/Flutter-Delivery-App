import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';

class RatingModel extends Rating {
  RatingModel({
    required super.id,
    required super.userId,
    required super.driverId,
    required super.comment,
    required super.ratingLevel,
    super.tip,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      userId: json['userId'],
      driverId: json['driverId'],
      comment: json['comment'],
      ratingLevel: json['ratingLevel'],
      tip: json['tip'] != null ? (json['tip'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'driverId': driverId,
      'comment': comment,
      'ratingLevel': ratingLevel,
      'tip': tip,
    };
  }
}

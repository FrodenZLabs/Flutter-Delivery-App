import 'package:flutter_delivery_app/data/models/rating/rating_model.dart';

class RatingCheckResponseModel {
  final bool canRate;
  final bool alreadyRated;
  final String currentStatus;
  final RatingModel? rating;

  RatingCheckResponseModel({
    required this.canRate,
    required this.alreadyRated,
    required this.currentStatus,
    this.rating,
  });

  factory RatingCheckResponseModel.fromJson(Map<String, dynamic> json) {
    return RatingCheckResponseModel(
      canRate: json['canRate'] ?? false,
      alreadyRated: json['alreadyRated'] ?? false,
      currentStatus: json['currentStatus'] ?? '',
      rating: json['rating'] != null
          ? RatingModel.fromJson(
              json['rating'] is Map<String, dynamic>
                  ? json['rating']
                  : {'id': json['rating'].toString()},
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'canRate': canRate,
    'alreadyRated': alreadyRated,
    'currentStatus': currentStatus,
    'rating': rating?.toJson(),
  };
}

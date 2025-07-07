import 'dart:convert';

import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';

RatingModel ratingModelFromRemoteJson(String str) {
  final jsonResponse = json.decode(str);
  return RatingModel.fromJson(jsonResponse['data'] ?? jsonResponse);
}

String ratingModelToJson(RatingModel data) => json.encode(data.toJson());

class RatingModel extends Rating {
  RatingModel({
    required super.id,
    required super.userId,
    required super.driverId,
    required super.comment,
    required super.scheduleId,
    required super.serviceId,
    required super.rating,
    required super.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      driverId: json['driverId'].toString(),
      comment: json['comment']?.toString() ?? '',
      scheduleId: json['scheduleId'].toString(),
      serviceId: json['serviceId'].toString(),
      rating: json['rating'] is int
          ? json['rating']
          : int.tryParse(json['rating'].toString()) ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'driverId': driverId,
      'comment': comment,
      'scheduleId': scheduleId,
      'serviceId': serviceId,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  RatingModel copyWith({
    String? id,
    String? userId,
    String? scheduleId,
    String? driverId,
    String? serviceId,
    String? comment,
    int? rating,
    DateTime? createdAt,
  }) {
    return RatingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      driverId: driverId ?? this.driverId,
      comment: comment ?? this.comment,
      scheduleId: scheduleId ?? this.scheduleId,
      serviceId: serviceId ?? this.serviceId,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

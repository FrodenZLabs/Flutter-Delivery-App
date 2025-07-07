import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/strings.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/data/models/rating/rating_model.dart';
import 'package:flutter_delivery_app/data/models/rating/rating_response_model.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class RatingRemoteDataSource {
  Future<RatingModel> addRating(RatingParams params, String token);
  Future<RatingCheckResponseModel> checkRating(String scheduleId, String token);
}

@LazySingleton(as: RatingRemoteDataSource)
class HttpRatingRemoteDataSource implements RatingRemoteDataSource {
  final http.Client client;

  HttpRatingRemoteDataSource(this.client);

  @override
  Future<RatingModel> addRating(RatingParams params, String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/schedules/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'scheduleId': params.scheduleId,
        'rating': params.rating,
        'comment': params.comment,
      }),
    );
    debugPrint("Response body: ${response.body}");
    debugPrint("Response status: ${response.statusCode}");

    if (response.statusCode == 201) {
      return ratingModelFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RatingCheckResponseModel> checkRating(
    String scheduleId,
    String token,
  ) async {
    final uri = Uri.parse('$baseUrl/ratings/eligible/$scheduleId');

    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint("Response body: ${response.body}");
    debugPrint("Response status: ${response.statusCode}");

    if (response.statusCode == 200) {
      return RatingCheckResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

import 'dart:convert';

import 'package:flutter_delivery_app/data/models/rating/rating_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class RatingRemoteDataSource {
  Future<void> addRating(RatingModel rating);
  Future<List<RatingModel>> getRatingsByUser(String userId);
}

@LazySingleton(as: RatingRemoteDataSource)
class HttpRatingRemoteDataSource implements RatingRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'http://localhost:5000/api/ratings';

  HttpRatingRemoteDataSource(this.client);

  @override
  Future<void> addRating(RatingModel rating) async {
    final response = await client.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(rating.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to submit rating');
    }
  }

  @override
  Future<List<RatingModel>> getRatingsByUser(String userId) async {
    final response = await client.get(Uri.parse('$baseUrl/user/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => RatingModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load ratings');
    }
  }
}

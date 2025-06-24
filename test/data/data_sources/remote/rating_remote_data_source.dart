import 'dart:convert';

import 'package:flutter_delivery_app/data/data_sources/remote/rating_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/rating/rating_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late RatingRemoteDataSource remoteDataSource;
  late MockClient mockClient;

  const baseUrl = 'http://localhost:5000/api/ratings';

  final ratingJson = {
    "id": "1",
    "userId": "user1",
    "driverId": "driver1",
    "comment": "Great service",
    "ratingLevel": "good",
    "tip": 100,
  };

  final ratingModel = RatingModel.fromJson(ratingJson);

  setUp(() {
    mockClient = MockClient();
    remoteDataSource = HttpRatingRemoteDataSource(mockClient);
  });

  group('addRating', () {
    test('should POST rating and return 201', () async {
      when(
        mockClient.post(
          Uri.parse('$baseUrl'),
          headers: anyNamed('headers'),
          body: jsonEncode(ratingModel.toJson()),
        ),
      ).thenAnswer((_) async => http.Response('', 201));

      await remoteDataSource.addRating(ratingModel);

      verify(
        mockClient.post(
          Uri.parse('$baseUrl'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(ratingModel.toJson()),
        ),
      ).called(1);
    });
  });

  group('getRatingsByUser', () {
    test('should GET ratings and return list of RatingModels', () async {
      when(
        mockClient.get(Uri.parse('$baseUrl/user/user1')),
      ).thenAnswer((_) async => http.Response(jsonEncode([ratingJson]), 200));

      final result = await remoteDataSource.getRatingsByUser('user1');

      expect(result, isA<List<RatingModel>>());
      expect(result.first.userId, 'user1');
    });
  });
}

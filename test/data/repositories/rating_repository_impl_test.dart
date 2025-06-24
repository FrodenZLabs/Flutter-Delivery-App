import 'package:flutter_delivery_app/data/models/rating/rating_model.dart';
import 'package:flutter_delivery_app/data/repositories_impl/rating_repository_impl.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late RatingRepositoryImpl repository;
  late MockRatingRemoteDataSource mockRemote;

  final ratingModel = RatingModel(
    id: '1',
    userId: 'user1',
    driverId: 'driver1',
    comment: 'Great service',
    ratingLevel: 'good',
    tip: 100,
  );

  setUp(() {
    mockRemote = MockRatingRemoteDataSource();
    repository = RatingRepositoryImpl(mockRemote);
  });

  group('addRating', () {
    test('should forward call to remote data source', () async {
      when(mockRemote.addRating(any)).thenAnswer((_) async => Future.value());

      await repository.addRating(ratingModel);

      verify(mockRemote.addRating(any)).called(1);
    });
  });

  group('getRatingsByUser', () {
    test('should return list of Rating entities from remote', () async {
      when(
        mockRemote.getRatingsByUser('user1'),
      ).thenAnswer((_) async => [ratingModel]);

      final result = await repository.getRatingsByUser('user1');

      expect(result, isA<List<Rating>>());
      expect(result.first.userId, 'user1');
    });
  });
}

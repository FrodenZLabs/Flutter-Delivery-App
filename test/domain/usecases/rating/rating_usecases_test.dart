import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/check_rating_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockRatingRepository mockRatingRepository;
  late AddRating addRating;
  late GetRatingsByUser getRatingsByUser;

  final testRating = Rating(
    id: '1',
    userId: 'user1',
    driverId: 'driver1',
    comment: 'Great service',
    ratingLevel: 'good',
    tip: 100,
  );

  setUp(() {
    mockRatingRepository = MockRatingRepository();
    addRating = AddRating(mockRatingRepository);
    getRatingsByUser = GetRatingsByUser(mockRatingRepository);
  });

  group('AddRating', () {
    test('should call repository.addRating once with correct data', () async {
      when(
        mockRatingRepository.addRating(testRating),
      ).thenAnswer((_) async => Future.value());

      await addRating(testRating);

      verify(mockRatingRepository.addRating(testRating)).called(1);
      verifyNoMoreInteractions(mockRatingRepository);
    });
  });

  group('GetRatingsByUser', () {
    test('should return a list of ratings for given userId', () async {
      when(
        mockRatingRepository.getRatingsByUser('user1'),
      ).thenAnswer((_) async => [testRating]);

      final result = await getRatingsByUser('user1');

      expect(result, isA<List<Rating>>());
      expect(result.first.userId, 'user1');
      verify(mockRatingRepository.getRatingsByUser('user1')).called(1);
      verifyNoMoreInteractions(mockRatingRepository);
    });
  });
}

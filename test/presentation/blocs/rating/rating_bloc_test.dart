import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/get_rating_by_user_id.dart';
import 'package:flutter_delivery_app/presentation/blocs/rating/rating_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late RatingBloc ratingBloc;
  late MockRatingRepository mockRepository;

  late AddRating addRating;
  late GetRatingsByUser getRatingsByUser;

  final rating = Rating(
    id: '1',
    userId: 'user1',
    driverId: 'driver1',
    comment: 'Excellent!',
    ratingLevel: 'good',
    tip: 200,
  );

  setUp(() {
    mockRepository = MockRatingRepository();
    addRating = AddRating(mockRepository);
    getRatingsByUser = GetRatingsByUser(mockRepository);

    ratingBloc = RatingBloc(
      addRating: addRating,
      getRatingsByUser: getRatingsByUser,
    );
  });

  tearDown(() => ratingBloc.close());

  group('AddRatingEvent', () {
    blocTest<RatingBloc, RatingState>(
      'emits [RatingLoading, RatingSuccess] when adding rating succeeds',
      build: () {
        when(
          mockRepository.addRating(rating),
        ).thenAnswer((_) async => Future.value());
        return ratingBloc;
      },
      act: (bloc) => bloc.add(AddRatingEvent(rating)),
      expect: () => [
        RatingLoading(),
        RatingSuccess('Rating submitted successfully'),
      ],
    );

    blocTest<RatingBloc, RatingState>(
      'emits [RatingLoading, RatingFailure] when adding rating fails',
      build: () {
        when(mockRepository.addRating(rating)).thenThrow(Exception('Failed'));
        return ratingBloc;
      },
      act: (bloc) => bloc.add(AddRatingEvent(rating)),
      expect: () => [RatingLoading(), isA<RatingFailure>()],
    );
  });

  group('GetRatingsByUserEvent', () {
    blocTest<RatingBloc, RatingState>(
      'emits [RatingLoading, RatingLoaded] when fetch succeeds',
      build: () {
        when(
          mockRepository.getRatingsByUser('user1'),
        ).thenAnswer((_) async => [rating]);
        return ratingBloc;
      },
      act: (bloc) => bloc.add(GetUserRatingsEvent('user1')),
      expect: () => [
        RatingLoading(),
        RatingLoaded([rating]),
      ],
    );

    blocTest<RatingBloc, RatingState>(
      'emits [RatingLoading, RatingFailure] when fetch fails',
      build: () {
        when(
          mockRepository.getRatingsByUser('user1'),
        ).thenThrow(Exception('Error fetching'));
        return ratingBloc;
      },
      act: (bloc) => bloc.add(GetUserRatingsEvent('user1')),
      expect: () => [RatingLoading(), isA<RatingFailure>()],
    );
  });
}

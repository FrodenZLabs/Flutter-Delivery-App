part of 'rating_bloc.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object?> get props => [];
}

class AddRatingEvent extends RatingEvent {
  final Rating rating;

  const AddRatingEvent(this.rating);

  @override
  List<Object?> get props => [rating];
}

class GetUserRatingsEvent extends RatingEvent {
  final String userId;

  const GetUserRatingsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

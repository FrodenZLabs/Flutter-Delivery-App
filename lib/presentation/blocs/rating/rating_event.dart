part of 'rating_bloc.dart';

abstract class RatingEvent {}

class AddRatingEvent extends RatingEvent {
  final RatingParams params;

  AddRatingEvent(this.params);
}

class CheckRatingsEvent extends RatingEvent {
  final String params;

  CheckRatingsEvent(this.params);
}

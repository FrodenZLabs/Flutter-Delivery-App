part of 'rating_bloc.dart';

abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingAddLoading extends RatingState {}

class RatingCheckLoading extends RatingState {}

class RatingAddSuccess extends RatingState {
  final Rating rating;

  RatingAddSuccess(this.rating);
}

class RatingCheckSuccess extends RatingState {
  final bool canRate;
  final String currentStatus;
  RatingCheckSuccess({required this.canRate, required this.currentStatus});
}

class RatingExistingSuccess extends RatingState {
  final Rating rating;
  RatingExistingSuccess(this.rating);
}

class RatingAddFailure extends RatingState {}

class RatingCheckFailure extends RatingState {}

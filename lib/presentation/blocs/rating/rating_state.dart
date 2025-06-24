part of 'rating_bloc.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object?> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSuccess extends RatingState {
  final String message;
  const RatingSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RatingFailure extends RatingState {
  final String error;

  const RatingFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class RatingLoaded extends RatingState {
  final List<Rating> ratings;

  const RatingLoaded(this.ratings);

  @override
  List<Object?> get props => [ratings];
}

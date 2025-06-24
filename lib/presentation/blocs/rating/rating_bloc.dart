import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/get_rating_by_user_id.dart';
import 'package:injectable/injectable.dart';

part 'rating_event.dart';
part 'rating_state.dart';

@injectable
class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final AddRating addRating;
  final GetRatingsByUser getRatingsByUser;

  RatingBloc({required this.addRating, required this.getRatingsByUser})
    : super(RatingInitial()) {
    on<AddRatingEvent>(_onAddRating);
    on<GetUserRatingsEvent>(_onGetUserRatings);
  }

  Future<void> _onAddRating(
    AddRatingEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());
    try {
      await addRating(event.rating);
      emit(RatingSuccess("Rating submitted successfully"));
    } catch (e) {
      emit(RatingFailure(e.toString()));
    }
  }

  Future<void> _onGetUserRatings(
    GetUserRatingsEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());
    try {
      final ratings = await getRatingsByUser(event.userId);
      emit(RatingLoaded(ratings));
    } catch (e) {
      emit(RatingFailure(e.toString()));
    }
  }
}

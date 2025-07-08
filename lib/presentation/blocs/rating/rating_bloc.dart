import 'package:bloc/bloc.dart';
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/check_rating_use_case.dart';
import 'package:injectable/injectable.dart';

part 'rating_event.dart';
part 'rating_state.dart';

@injectable
class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final AddRatingUseCase addRatingUseCase;
  final CheckRatingUseCase checkRatingUseCase;
  final UserLocalDataSource userLocalDataSource;

  RatingBloc(
    this.addRatingUseCase,
    this.checkRatingUseCase,
    this.userLocalDataSource,
  ) : super(RatingInitial()) {
    on<AddRatingEvent>(_onAddRating);
    on<CheckRatingsEvent>(_onCheckRatings);
  }

  Future<void> _onAddRating(
    AddRatingEvent event,
    Emitter<RatingState> emit,
  ) async {
    try {
      emit(RatingAddLoading());

      final result = await addRatingUseCase(event.params);
      result.fold(
        (failure) => emit(RatingAddFailure()),
        (rating) => emit(RatingAddSuccess(rating)),
      );
    } catch (e) {
      emit(RatingAddFailure());
    }
  }

  Future<void> _onCheckRatings(
    CheckRatingsEvent event,
    Emitter<RatingState> emit,
  ) async {
    try {
      emit(RatingCheckLoading());

      final result = await checkRatingUseCase(event.params);

      result.fold((failure) => emit(RatingCheckFailure()), (response) {
        if (response.alreadyRated && response.rating != null) {
          // Case when rating already exists
          emit(RatingExistingSuccess(response.rating!));
        } else {
          // Case when checking eligibility
          emit(
            RatingCheckSuccess(
              canRate: response.canRate,
              currentStatus: response.currentStatus,
            ),
          );
        }
      });
    } catch (e) {
      emit(RatingCheckFailure());
    }
  }
}

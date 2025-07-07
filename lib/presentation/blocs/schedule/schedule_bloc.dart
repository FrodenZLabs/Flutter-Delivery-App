import 'package:bloc/bloc.dart';
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/book_schedule_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedules_by_user_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/update_schedule.dart';
import 'package:injectable/injectable.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

@injectable
class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final BookScheduleUseCase _bookScheduleUseCase;
  final UpdateSchedule updateSchedule;
  final GetSchedulesByUserUseCase _getSchedulesByUserUseCase;
  final UserLocalDataSource _userLocalDataSource;

  ScheduleBloc(
    this._bookScheduleUseCase,
    this.updateSchedule,
    this._getSchedulesByUserUseCase,
    this._userLocalDataSource,
  ) : super(ScheduleInitial()) {
    on<BookScheduleEvent>(_onBook);
    on<GetSchedulesByUserEvent>(_onLoadSchedules);
  }

  Future<void> _onBook(
    BookScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      emit(ScheduleLoading());
      final userId = await _userLocalDataSource.getUserId();
      final updatedParams = event.params.copyWith(userId: userId);

      final result = await _bookScheduleUseCase(updatedParams);
      result.fold(
        (failure) => emit(ScheduleFailure()),
        (schedule) => emit(ScheduleAddSuccess(schedule)),
      );
    } catch (e) {
      emit(ScheduleFailure());
    }
  }

  Future<void> _onLoadSchedules(
    GetSchedulesByUserEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      emit(ScheduleFetchLoading());
      final userId = await _userLocalDataSource.getUserId();
      final updatedParams = event.params.copyWith(userId: userId);

      final result = await _getSchedulesByUserUseCase(updatedParams);

      result.fold((failure) => emit(ScheduleFetchFail()), (schedules) {
        final models = schedules.map((s) => s as ScheduleModel).toList();
        emit(ScheduleFetchSuccess(models));
      });
    } catch (e) {
      emit(ScheduleFetchFail());
    }
  }
}

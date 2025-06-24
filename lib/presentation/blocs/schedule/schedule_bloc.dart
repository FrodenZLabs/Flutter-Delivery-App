import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/book_schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/cancel_schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedule_by_id.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedules_by_user.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/update_schedule.dart';
import 'package:injectable/injectable.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

@injectable
class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final BookSchedule bookSchedule;
  final UpdateSchedule updateSchedule;
  final CancelSchedule cancelSchedule;
  final GetScheduleById getScheduleById;
  final GetSchedulesByUser getSchedulesByUser;

  ScheduleBloc({
    required this.bookSchedule,
    required this.updateSchedule,
    required this.cancelSchedule,
    required this.getScheduleById,
    required this.getSchedulesByUser,
  }) : super(ScheduleInitial()) {
    on<BookScheduleEvent>(_onBook);
    on<UpdateScheduleEvent>(_onUpdate);
    on<CancelScheduleEvent>(_onCancel);
    on<GetScheduleByIdEvent>(_onGetById);
    on<GetSchedulesByUserEvent>(_onGetByUser);
  }

  Future<void> _onBook(
    BookScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await bookSchedule(event.schedule);
      emit(ScheduleSuccess(message: 'Schedule booked successfully'));
    } catch (e) {
      emit(ScheduleFailure(e.toString()));
    }
  }

  Future<void> _onUpdate(
    UpdateScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await updateSchedule(event.schedule);
      emit(ScheduleSuccess(message: 'Schedule updated successfully'));
    } catch (e) {
      emit(ScheduleFailure(e.toString()));
    }
  }

  Future<void> _onCancel(
    CancelScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await cancelSchedule(event.scheduleId);
      emit(ScheduleSuccess(message: 'Schedule cancelled'));
    } catch (e) {
      emit(ScheduleFailure(e.toString()));
    }
  }

  Future<void> _onGetById(
    GetScheduleByIdEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final schedule = await getScheduleById(event.scheduleId);
      emit(SingleScheduleLoaded(schedule!));
    } catch (e) {
      emit(ScheduleFailure(e.toString()));
    }
  }

  Future<void> _onGetByUser(
    GetSchedulesByUserEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final schedules = await getSchedulesByUser(event.userId);
      emit(ScheduleLoaded(schedules));
    } catch (e) {
      emit(ScheduleFailure(e.toString()));
    }
  }
}

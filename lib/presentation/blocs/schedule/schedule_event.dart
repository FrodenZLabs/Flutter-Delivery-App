part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookScheduleEvent extends ScheduleEvent {
  final Schedule schedule;

  BookScheduleEvent(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class UpdateScheduleEvent extends ScheduleEvent {
  final Schedule schedule;

  UpdateScheduleEvent(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class CancelScheduleEvent extends ScheduleEvent {
  final String scheduleId;

  CancelScheduleEvent(this.scheduleId);

  @override
  List<Object?> get props => [scheduleId];
}

class GetScheduleByIdEvent extends ScheduleEvent {
  final String scheduleId;

  GetScheduleByIdEvent(this.scheduleId);

  @override
  List<Object?> get props => [scheduleId];
}

class GetSchedulesByUserEvent extends ScheduleEvent {
  final String userId;

  GetSchedulesByUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

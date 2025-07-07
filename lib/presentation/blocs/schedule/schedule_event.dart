part of 'schedule_bloc.dart';

abstract class ScheduleEvent {}

class BookScheduleEvent extends ScheduleEvent {
  final ScheduleModel params;

  BookScheduleEvent(this.params);
}

class GetSchedulesByUserEvent extends ScheduleEvent {
  final ScheduleModel params;

  GetSchedulesByUserEvent(this.params);
}

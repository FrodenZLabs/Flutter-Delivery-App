part of 'schedule_bloc.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleAddSuccess extends ScheduleState {
  final Schedule schedule;

  ScheduleAddSuccess(this.schedule);
}

class ScheduleFailure extends ScheduleState {}

// Fetch schedule
class ScheduleFetchLoading extends ScheduleState {}

class ScheduleFetchSuccess extends ScheduleState {
  final List<ScheduleModel> schedule;

  ScheduleFetchSuccess(this.schedule);
}

class ScheduleFetchFail extends ScheduleState {}

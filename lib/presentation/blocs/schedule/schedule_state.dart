part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final String message;

  ScheduleSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ScheduleLoaded extends ScheduleState {
  final List<Schedule> schedules;

  ScheduleLoaded(this.schedules);

  @override
  List<Object?> get props => [schedules];
}

class SingleScheduleLoaded extends ScheduleState {
  final Schedule schedule;

  SingleScheduleLoaded(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class ScheduleFailure extends ScheduleState {
  final String error;

  ScheduleFailure(this.error);

  @override
  List<Object?> get props => [error];
}

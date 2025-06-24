import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateSchedule {
  final ScheduleRepository repository;

  UpdateSchedule(this.repository);

  Future<void> call(Schedule schedule) {
    return repository.updateSchedule(schedule);
  }
}

import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CancelSchedule {
  final ScheduleRepository repository;

  CancelSchedule(this.repository);

  Future<void> call(String scheduleId) {
    return repository.cancelSchedule(scheduleId);
  }
}

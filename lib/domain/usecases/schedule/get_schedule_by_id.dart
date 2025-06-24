import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetScheduleById {
  final ScheduleRepository repository;

  GetScheduleById(this.repository);

  Future<Schedule?> call(String scheduleId) {
    return repository.getScheduleById(scheduleId);
  }
}

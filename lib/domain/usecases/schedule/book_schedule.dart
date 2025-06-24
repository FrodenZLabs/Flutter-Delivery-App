import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BookSchedule {
  final ScheduleRepository repository;

  BookSchedule(this.repository);

  Future<void> call(Schedule schedule) {
    return repository.bookSchedule(schedule);
  }
}

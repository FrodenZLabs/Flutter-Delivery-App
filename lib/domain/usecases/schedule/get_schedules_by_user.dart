import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSchedulesByUser {
  final ScheduleRepository repository;

  GetSchedulesByUser(this.repository);

  Future<List<Schedule>> call(String userId) {
    return repository.getSchedulesByUser(userId);
  }
}

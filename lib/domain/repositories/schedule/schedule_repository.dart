import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';

abstract class ScheduleRepository {
  Future<void> bookSchedule(Schedule schedule);
  Future<void> updateSchedule(Schedule schedule);
  Future<void> cancelSchedule(String scheduleId);
  Future<List<Schedule>> getSchedulesByUser(String userId);
  Future<Schedule?> getScheduleById(String scheduleId);
}

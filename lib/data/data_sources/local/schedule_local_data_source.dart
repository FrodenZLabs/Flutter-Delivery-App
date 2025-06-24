import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class ScheduleLocalDataSource {
  Future<void> cacheSchedule(ScheduleModel schedule);
  Future<void> updateSchedule(ScheduleModel schedule);
  Future<void> deleteSchedule(String id);
  Future<ScheduleModel?> getScheduleById(String id);
  Future<List<ScheduleModel>> getSchedulesByUser(String userId);
  Future<void> syncAllSchedules(List<ScheduleModel> schedules);
}

@LazySingleton(as: ScheduleLocalDataSource)
class HiveScheduleLocalDataSource implements ScheduleLocalDataSource {
  static const String boxName = 'scheduleBox';

  Future<Box<ScheduleModel>> _openBox() => Hive.openBox<ScheduleModel>(boxName);

  @override
  Future<void> cacheSchedule(ScheduleModel schedule) async {
    final box = await _openBox();
    await box.put(schedule.id, schedule);
  }

  @override
  Future<void> updateSchedule(ScheduleModel schedule) async {
    final box = await _openBox();
    final existing = box.get(schedule.id);
    if (existing != null) {
      final updated = existing.copyWith(
        deliveryInfoId: schedule.deliveryInfoId,
        scheduleDate: schedule.scheduleDate,
        scheduleTime: schedule.scheduleTime,
        status: schedule.status,
      );
      await box.put(schedule.id, updated);
    } else {
      await box.put(schedule.id, schedule);
    }
  }

  @override
  Future<void> deleteSchedule(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  @override
  Future<ScheduleModel?> getScheduleById(String id) async {
    final box = await _openBox();
    return box.get(id);
  }

  @override
  Future<List<ScheduleModel>> getSchedulesByUser(String userId) async {
    final box = await _openBox();
    return box.values.where((s) => s.userId == userId).toList();
  }

  @override
  Future<void> syncAllSchedules(List<ScheduleModel> schedules) async {
    final box = await _openBox();
    for (final schedule in schedules) {
      await box.put(schedule.id, schedule);
    }
  }
}

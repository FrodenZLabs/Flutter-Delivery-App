import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class ScheduleLocalDataSource {
  Future<void> cacheSchedule(List<ScheduleModel> params);
  Future<void> updateSchedule(ScheduleModel params);
  Future<List<ScheduleModel>> getSchedulesByUser(String userId);
}

@LazySingleton(as: ScheduleLocalDataSource)
class HiveScheduleLocalDataSource implements ScheduleLocalDataSource {
  static const String boxName = 'scheduleBox';

  Future<Box<ScheduleModel>> _openBox() => Hive.openBox<ScheduleModel>(boxName);

  @override
  Future<void> updateSchedule(ScheduleModel params) async {
    final box = await _openBox();
    final existing = box.get(params.id);
    if (existing != null) {
      final updated = existing.copyWith(
        deliveryInfoId: params.deliveryInfoId,
        scheduleDate: params.scheduleDate,
        scheduleTime: params.scheduleTime,
        status: params.status,
      );
      await box.put(params.id, updated);
    } else {
      await box.put(params.id, params);
    }
  }

  @override
  Future<List<ScheduleModel>> getSchedulesByUser(String userId) async {
    final box = await _openBox();
    return box.values.where((s) => s.userId == userId).toList();
  }

  @override
  Future<void> cacheSchedule(List<ScheduleModel> params) async {
    final box = await _openBox();
    await box.clear();
    for (var schedule in params) {
      await box.put(schedule.id, schedule);
    }
  }
}

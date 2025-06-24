import 'package:flutter_delivery_app/data/data_sources/local/schedule_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/schedule_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remote;
  final ScheduleLocalDataSource local;

  ScheduleRepositoryImpl(this.remote, this.local);

  @override
  Future<void> bookSchedule(Schedule schedule) async {
    final model = schedule as ScheduleModel;
    await remote.bookSchedule(model);
    await local.cacheSchedule(model); // Redundant but ensures it's cached
  }

  @override
  Future<void> updateSchedule(Schedule schedule) async {
    final model = schedule as ScheduleModel;
    await remote.updateSchedule(model);
    await local.updateSchedule(model);
  }

  @override
  Future<void> cancelSchedule(String id) async {
    await remote.cancelSchedule(id);
    await local.deleteSchedule(id);
  }

  @override
  Future<Schedule?> getScheduleById(String id) async {
    // Prefer local first (offline support)
    final localData = await local.getScheduleById(id);
    if (localData != null) return localData;

    return await remote.getScheduleById(id);
  }

  @override
  Future<List<Schedule>> getSchedulesByUser(String userId) async {
    try {
      final remoteData = await remote.getSchedulesByUser(userId);
      return remoteData;
    } catch (_) {
      return await local.getSchedulesByUser(userId); // Fallback offline
    }
  }
}

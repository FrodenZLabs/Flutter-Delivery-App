import 'dart:convert';

import 'package:flutter_delivery_app/data/data_sources/local/schedule_local_data_source.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class ScheduleRemoteDataSource {
  Future<void> bookSchedule(ScheduleModel schedule);
  Future<void> updateSchedule(ScheduleModel schedule);
  Future<void> cancelSchedule(String id);
  Future<ScheduleModel?> getScheduleById(String id);
  Future<List<ScheduleModel>> getSchedulesByUser(String userId);
}

@LazySingleton(as: ScheduleRemoteDataSource)
class HttpScheduleRemoteDataSource implements ScheduleRemoteDataSource {
  final http.Client client;
  final ScheduleLocalDataSource local;

  HttpScheduleRemoteDataSource(this.client, this.local);

  final String baseUrl = 'http://localhost:5000/api/schedule';

  @override
  Future<void> bookSchedule(ScheduleModel schedule) async {
    final res = await client.post(
      Uri.parse('$baseUrl/book'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(schedule.toJson()),
    );

    if (res.statusCode == 201) {
      final data = jsonDecode(res.body);
      final created = ScheduleModel.fromJson(data);
      await local.cacheSchedule(created);
    }
  }

  @override
  Future<void> updateSchedule(ScheduleModel schedule) async {
    final res = await client.put(
      Uri.parse('$baseUrl/update/${schedule.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(schedule.toJson()),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final updated = ScheduleModel.fromJson(data);
      await local.updateSchedule(updated);
    }
  }

  @override
  Future<void> cancelSchedule(String id) async {
    final res = await client.delete(Uri.parse('$baseUrl/cancel/$id'));

    if (res.statusCode == 200) {
      await local.deleteSchedule(id);
    }
  }

  @override
  Future<ScheduleModel?> getScheduleById(String id) async {
    final res = await client.get(Uri.parse('$baseUrl/$id'));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final schedule = ScheduleModel.fromJson(data);
      await local.cacheSchedule(schedule);
      return schedule;
    }
    return null;
  }

  @override
  Future<List<ScheduleModel>> getSchedulesByUser(String userId) async {
    final res = await client.get(Uri.parse('$baseUrl/user/$userId'));

    if (res.statusCode == 200) {
      final List list = jsonDecode(res.body);
      final schedules = list.map((e) => ScheduleModel.fromJson(e)).toList();

      // Replace local data with remote data
      await local.syncAllSchedules(schedules);

      return schedules;
    }
    return [];
  }
}

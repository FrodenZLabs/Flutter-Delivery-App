import 'package:flutter_delivery_app/core/constants/strings.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class ScheduleRemoteDataSource {
  Future<ScheduleModel> bookSchedule(ScheduleModel params, String token);
  Future<List<ScheduleModel>> getSchedulesInfo(
    ScheduleModel params,
    String userId,
    String token,
  );
}

@LazySingleton(as: ScheduleRemoteDataSource)
class HttpScheduleRemoteDataSource implements ScheduleRemoteDataSource {
  final http.Client client;

  HttpScheduleRemoteDataSource({required this.client});

  @override
  Future<ScheduleModel> bookSchedule(ScheduleModel params, String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/schedules/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: scheduleModelToJson(params),
    );

    if (response.statusCode == 201) {
      return scheduleModelFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ScheduleModel>> getSchedulesInfo(
    ScheduleModel params,
    String userId,
    String token,
  ) async {
    final uri = Uri.parse('$baseUrl/schedules/user/$userId').replace(
      queryParameters: {if (params.status.isNotEmpty) 'status': params.status},
    );

    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return scheduleModelListFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }
}

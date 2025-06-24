import 'dart:convert';

import 'package:flutter_delivery_app/data/data_sources/remote/schedule_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late HttpScheduleRemoteDataSource remoteDataSource;
  late MockClient mockClient;
  late MockScheduleLocalDataSource mockLocal;

  final testModel = ScheduleModel(
    id: '1',
    userId: 'user1',
    serviceId: 'service1',
    deliveryInfoId: 'delivery1',
    scheduleDate: DateTime(2025, 7, 1),
    scheduleTime: '10:00 AM',
    status: 'scheduled',
  );

  setUp(() {
    mockClient = MockClient();
    mockLocal = MockScheduleLocalDataSource();
    remoteDataSource = HttpScheduleRemoteDataSource(mockClient, mockLocal);
  });

  test('should book a schedule via POST and cache it', () async {
    when(
      mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode(testModel.toJson()), 201),
    );

    await remoteDataSource.bookSchedule(testModel);

    verify(
      mockClient.post(
        Uri.parse('http://localhost:5000/api/schedule/book'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(testModel.toJson()),
      ),
    ).called(1);
    verify(mockLocal.cacheSchedule(any)).called(1);
  });

  test('should update a schedule via PUT', () async {
    when(
      mockClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode(testModel.toJson()), 200),
    );

    await remoteDataSource.updateSchedule(testModel);

    verify(mockLocal.updateSchedule(any)).called(1);
  });

  test('should delete a schedule via DELETE', () async {
    when(
      mockClient.delete(any),
    ).thenAnswer((_) async => http.Response('{}', 200));

    await remoteDataSource.cancelSchedule(testModel.id);

    verify(
      mockClient.delete(
        Uri.parse('http://localhost:5000/api/schedule/cancel/${testModel.id}'),
      ),
    ).called(1);
    verify(mockLocal.deleteSchedule(testModel.id)).called(1);
  });

  test('should return schedule by ID via GET and cache it', () async {
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response(jsonEncode(testModel.toJson()), 200),
    );

    final result = await remoteDataSource.getScheduleById(testModel.id);

    expect(result?.id, equals(testModel.id));
    verify(mockLocal.cacheSchedule(any)).called(1);
  });
}

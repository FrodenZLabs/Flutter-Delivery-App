import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/data/repositories_impl/schedule_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late ScheduleRepositoryImpl repository;
  late MockScheduleRemoteDataSource mockRemote;
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
    mockRemote = MockScheduleRemoteDataSource();
    mockLocal = MockScheduleLocalDataSource();
    repository = ScheduleRepositoryImpl(mockRemote, mockLocal);
  });

  test('should call remote.bookSchedule and local.cacheSchedule', () async {
    when(mockRemote.bookSchedule(testModel)).thenAnswer((_) async {});
    when(mockLocal.cacheSchedule(testModel)).thenAnswer((_) async {});

    await repository.bookSchedule(testModel);

    verify(mockRemote.bookSchedule(testModel)).called(1);
    verify(mockLocal.cacheSchedule(testModel)).called(1);
  });

  test('should call remote.updateSchedule and local.updateSchedule', () async {
    when(mockRemote.updateSchedule(testModel)).thenAnswer((_) async {});
    when(mockLocal.updateSchedule(testModel)).thenAnswer((_) async {});

    await repository.updateSchedule(testModel);

    verify(mockRemote.updateSchedule(testModel)).called(1);
    verify(mockLocal.updateSchedule(testModel)).called(1);
  });

  test('should call remote.cancelSchedule and local.deleteSchedule', () async {
    when(mockRemote.cancelSchedule(testModel.id)).thenAnswer((_) async {});
    when(mockLocal.deleteSchedule(testModel.id)).thenAnswer((_) async {});

    await repository.cancelSchedule(testModel.id);

    verify(mockRemote.cancelSchedule(testModel.id)).called(1);
    verify(mockLocal.deleteSchedule(testModel.id)).called(1);
  });

  test('should return schedule by ID from local', () async {
    when(
      mockLocal.getScheduleById(testModel.id),
    ).thenAnswer((_) async => testModel);

    final result = await repository.getScheduleById(testModel.id);

    expect(result, equals(testModel));
    verify(mockLocal.getScheduleById(testModel.id)).called(1);
  });

  test('should return schedules list by user from local', () async {
    when(
      mockLocal.getSchedulesByUser(testModel.userId),
    ).thenAnswer((_) async => [testModel]);

    final result = await repository.getSchedulesByUser(testModel.userId);

    expect(result.length, 1);
    expect(result.first.id, testModel.id);
    verify(mockLocal.getSchedulesByUser(testModel.userId)).called(1);
  });
}

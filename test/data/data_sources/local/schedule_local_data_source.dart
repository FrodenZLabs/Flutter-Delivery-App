import 'package:flutter_delivery_app/data/data_sources/local/schedule_local_data_source.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late HiveScheduleLocalDataSource localDataSource;
  late MockBox<ScheduleModel> mockBox;

  final testModel = ScheduleModel(
    id: '1',
    userId: 'user1',
    serviceId: 'service1',
    deliveryInfoId: 'delivery1',
    scheduleDate: DateTime(2025, 7, 1),
    scheduleTime: '10:00 AM',
    status: 'scheduled',
  );

  setUpAll(() {
    Hive.init('test_hive_path');
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(ScheduleModelAdapter());
    }
  });

  setUp(() async {
    mockBox = MockBox<ScheduleModel>();
    localDataSource = HiveScheduleLocalDataSource();

    final box = await Hive.openBox<ScheduleModel>('scheduleBox');
    await box.clear(); // Clean start
  });

  test('should cache a schedule', () async {
    await localDataSource.cacheSchedule(testModel);
    final box = await Hive.openBox<ScheduleModel>('scheduleBox');
    expect(box.get(testModel.id), testModel);
  });

  test('should update a schedule', () async {
    final box = await Hive.openBox<ScheduleModel>('scheduleBox');
    await box.put(testModel.id, testModel);
    final updated = testModel.copyWith(status: 'completed');
    await localDataSource.updateSchedule(updated);
    expect((await box.get(testModel.id))?.status, equals('completed'));
  });

  test('should delete a schedule', () async {
    final box = await Hive.openBox<ScheduleModel>('scheduleBox');
    await box.put(testModel.id, testModel);
    await localDataSource.deleteSchedule(testModel.id);
    expect(box.get(testModel.id), null);
  });

  test('should return schedule by ID', () async {
    final box = await Hive.openBox<ScheduleModel>('scheduleBox');
    await box.put(testModel.id, testModel);
    final result = await localDataSource.getScheduleById(testModel.id);
    expect(result, equals(testModel));
  });

  test('should return list of user schedules', () async {
    final box = await Hive.openBox<ScheduleModel>('scheduleBox');
    await box.put(testModel.id, testModel);
    final list = await localDataSource.getSchedulesByUser(testModel.userId);
    expect(list.length, 1);
    expect(list.first.userId, equals('user1'));
  });

  test('should sync all schedules', () async {
    final box = await Hive.openBox<ScheduleModel>('scheduleBox');
    await localDataSource.syncAllSchedules([testModel]);
    expect(box.get(testModel.id), equals(testModel));
  });
}

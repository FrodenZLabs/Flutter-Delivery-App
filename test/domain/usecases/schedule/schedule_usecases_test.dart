import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/book_schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/cancel_schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedule_by_id.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedules_by_user.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/update_schedule.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockScheduleRepository mockRepository;
  late BookSchedule bookSchedule;
  late UpdateSchedule updateSchedule;
  late CancelSchedule cancelSchedule;
  late GetScheduleById getScheduleById;
  late GetSchedulesByUser getSchedulesByUser;

  final testSchedule = Schedule(
    id: '1',
    userId: 'user1',
    serviceId: 'service1',
    deliveryInfoId: 'delivery1',
    scheduleDate: DateTime(2025, 7, 1),
    scheduleTime: '10:00 AM',
    status: 'scheduled',
  );

  setUp(() {
    mockRepository = MockScheduleRepository();
    bookSchedule = BookSchedule(mockRepository);
    updateSchedule = UpdateSchedule(mockRepository);
    cancelSchedule = CancelSchedule(mockRepository);
    getScheduleById = GetScheduleById(mockRepository);
    getSchedulesByUser = GetSchedulesByUser(mockRepository);
  });

  group('Schedule UseCases', () {
    test('BookSchedule should call repository with correct data', () async {
      when(
        mockRepository.bookSchedule(testSchedule),
      ).thenAnswer((_) async => Future.value());

      await bookSchedule(testSchedule);

      verify(mockRepository.bookSchedule(testSchedule)).called(1);
    });

    test('UpdateSchedule should call repository with updated data', () async {
      when(
        mockRepository.updateSchedule(testSchedule),
      ).thenAnswer((_) async => Future.value());

      await updateSchedule(testSchedule);

      verify(mockRepository.updateSchedule(testSchedule)).called(1);
    });

    test('CancelSchedule should call repository with schedule ID', () async {
      when(
        mockRepository.cancelSchedule('1'),
      ).thenAnswer((_) async => Future.value());

      await cancelSchedule('1');

      verify(mockRepository.cancelSchedule('1')).called(1);
    });

    test('GetScheduleById should return a schedule from repository', () async {
      when(
        mockRepository.getScheduleById('1'),
      ).thenAnswer((_) async => testSchedule);

      final result = await getScheduleById('1');

      expect(result, equals(testSchedule));
      verify(mockRepository.getScheduleById('1')).called(1);
    });

    test('GetSchedulesByUser should return a list from repository', () async {
      when(
        mockRepository.getSchedulesByUser('user1'),
      ).thenAnswer((_) async => [testSchedule]);

      final result = await getSchedulesByUser('user1');

      expect(result, isA<List<Schedule>>());
      expect(result.first.userId, equals('user1'));
      verify(mockRepository.getSchedulesByUser('user1')).called(1);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/book_schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/cancel_schedule.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedule_by_id.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedules_by_user.dart';
import 'package:flutter_delivery_app/domain/usecases/schedule/update_schedule.dart';
import 'package:flutter_delivery_app/presentation/blocs/schedule/schedule_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late ScheduleBloc scheduleBloc;
  late MockScheduleRepository mockRepository;

  // ✅ Use case instances
  late BookSchedule bookSchedule;
  late UpdateSchedule updateSchedule;
  late CancelSchedule cancelSchedule;
  late GetScheduleById getScheduleById;
  late GetSchedulesByUser getSchedulesByUser;

  final schedule = ScheduleModel(
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

    scheduleBloc = ScheduleBloc(
      bookSchedule: bookSchedule,
      updateSchedule: updateSchedule,
      cancelSchedule: cancelSchedule,
      getScheduleById: getScheduleById,
      getSchedulesByUser: getSchedulesByUser,
    );
  });

  tearDown(() => scheduleBloc.close());

  group('BookSchedule', () {
    blocTest<ScheduleBloc, ScheduleState>(
      'emits [Loading, Success] when booking succeeds',
      build: () {
        when(mockRepository.bookSchedule(schedule)).thenAnswer((_) async {});
        return scheduleBloc;
      },
      act: (bloc) => bloc.add(BookScheduleEvent(schedule)),
      expect: () => [
        ScheduleLoading(),
        ScheduleSuccess(message: 'Schedule booked successfully'),
      ],
    );

    blocTest<ScheduleBloc, ScheduleState>(
      'emits [Loading, Failure] when booking fails',
      build: () {
        when(
          mockRepository.bookSchedule(schedule),
        ).thenThrow(Exception('Failed'));
        return scheduleBloc;
      },
      act: (bloc) => bloc.add(BookScheduleEvent(schedule)),
      expect: () => [ScheduleLoading(), isA<ScheduleFailure>()],
    );
  });

  group('UpdateSchedule', () {
    blocTest<ScheduleBloc, ScheduleState>(
      'emits [Loading, Success] when update succeeds',
      build: () {
        when(mockRepository.updateSchedule(schedule)).thenAnswer((_) async {});
        return scheduleBloc;
      },
      act: (bloc) => bloc.add(UpdateScheduleEvent(schedule)),
      expect: () => [
        ScheduleLoading(),
        ScheduleSuccess(message: 'Schedule updated successfully'),
      ],
    );
  });

  group('CancelSchedule', () {
    blocTest<ScheduleBloc, ScheduleState>(
      'emits [Loading, Success] when cancel succeeds',
      build: () {
        when(
          mockRepository.cancelSchedule(schedule.id),
        ).thenAnswer((_) async {});
        return scheduleBloc;
      },
      act: (bloc) => bloc.add(CancelScheduleEvent(schedule.id)),
      expect: () => [
        ScheduleLoading(),
        ScheduleSuccess(message: 'Schedule cancelled'),
      ],
    );
  });

  group('GetUserSchedules', () {
    blocTest<ScheduleBloc, ScheduleState>(
      'emits [Loading, Loaded] with schedules',
      build: () {
        when(
          mockRepository.getSchedulesByUser('user1'),
        ).thenAnswer((_) async => [schedule]);
        return scheduleBloc;
      },
      act: (bloc) => bloc.add(GetSchedulesByUserEvent('user1')),
      expect: () => [
        ScheduleLoading(),
        ScheduleLoaded([schedule]),
      ],
    );
  });
}

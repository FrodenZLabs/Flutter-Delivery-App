import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/add_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/delete_local_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/get_local_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/get_remote_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/get_selected_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/select_delivery_info_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockDeliveryInfoRepository mockRepo;

  const testDeliveryInfo = DeliveryInfo(
    id: '1',
    userId: 'user1',
    address: '123 Street',
    city: 'Nairobi',
    contactNumber: '0700123456',
    isDefault: false,
  );

  setUp(() {
    mockRepo = MockDeliveryInfoRepository();
  });

  test('AddDeliveryInfo should call repository method', () async {
    final usecase = AddDeliveryInfo(mockRepo);
    when(
      mockRepo.addDeliveryInfo(testDeliveryInfo),
    ).thenAnswer((_) async => null);

    await usecase(testDeliveryInfo);

    verify(mockRepo.addDeliveryInfo(testDeliveryInfo)).called(1);
  });

  test('UpdateDeliveryInfo should call repository method', () async {
    final usecase = UpdateDeliveryInfo(mockRepo);
    when(
      mockRepo.updateDeliveryInfo(testDeliveryInfo),
    ).thenAnswer((_) async => null);

    await usecase(testDeliveryInfo);

    verify(mockRepo.updateDeliveryInfo(testDeliveryInfo)).called(1);
  });

  test(
    'DeleteDeliveryInfo should call repository method with correct ID',
    () async {
      final usecase = DeleteDeliveryInfo(mockRepo);
      when(mockRepo.deleteDeliveryInfo('1')).thenAnswer((_) async => null);

      await usecase('1');

      verify(mockRepo.deleteDeliveryInfo('1')).called(1);
    },
  );

  test('GetDeliveryInfoList should return a list for given user', () async {
    final usecase = GetAllDeliveryInfo(mockRepo);
    when(
      mockRepo.getAllDeliveryInfo('user1'),
    ).thenAnswer((_) async => [testDeliveryInfo]);

    final result = await usecase('user1');

    expect(result, isA<List<DeliveryInfo>>());
    expect(result.length, 1);
    verify(mockRepo.getAllDeliveryInfo('user1')).called(1);
  });

  test(
    'SetDefaultDeliveryInfo should call repository with correct ID',
    () async {
      final usecase = SetDefaultDeliveryInfo(mockRepo);
      when(mockRepo.setDefaultDeliveryInfo('1')).thenAnswer((_) async => null);

      await usecase('1');

      verify(mockRepo.setDefaultDeliveryInfo('1')).called(1);
    },
  );

  test(
    'GetDefaultDeliveryInfo should return default address for user',
    () async {
      final usecase = GetDefaultDeliveryInfo(mockRepo);
      when(
        mockRepo.getDefaultDeliveryInfo('user1'),
      ).thenAnswer((_) async => testDeliveryInfo);

      final result = await usecase('user1');

      expect(result, testDeliveryInfo);
      verify(mockRepo.getDefaultDeliveryInfo('user1')).called(1);
    },
  );
}

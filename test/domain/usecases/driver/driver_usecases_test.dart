import 'package:flutter_delivery_app/domain/entities/driver/driver.dart';
import 'package:flutter_delivery_app/domain/usecases/driver/get_driver_by_id.dart';
import 'package:flutter_delivery_app/domain/usecases/driver/get_drivers_by_service_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockDriverRepository mockDriverRepository;
  late GetDriverById getDriverById;
  late GetDriversByServiceId getDriversByServiceId;

  final driver = Driver(
    id: 'driver1',
    serviceId: 'service1',
    firstName: 'John',
    lastName: 'Doe',
    contactNumber: '0712345678',
    licensePlate: 'KDA 123X',
    vehicleType: 'Van',
    profilePictureUrl: 'http://image.com/profile.jpg',
  );

  setUp(() {
    mockDriverRepository = MockDriverRepository();
    getDriverById = GetDriverById(mockDriverRepository);
    getDriversByServiceId = GetDriversByServiceId(mockDriverRepository);
  });

  group('GetDriverById', () {
    test('should return driver from repository when ID is valid', () async {
      // arrange
      when(
        mockDriverRepository.getDriverById('driver1'),
      ).thenAnswer((_) async => driver);

      // act
      final result = await getDriverById('driver1');

      // assert
      expect(result, driver);
      verify(mockDriverRepository.getDriverById('driver1')).called(1);
      verifyNoMoreInteractions(mockDriverRepository);
    });
  });

  group('GetDriversByServiceId', () {
    test(
      'should return list of drivers from repository for a given service ID',
      () async {
        // arrange
        when(
          mockDriverRepository.getDriversByServiceId('service1'),
        ).thenAnswer((_) async => [driver]);

        // act
        final result = await getDriversByServiceId('service1');

        // assert
        expect(result, isA<List<Driver>>());
        expect(result.length, 1);
        expect(result.first, driver);
        verify(
          mockDriverRepository.getDriversByServiceId('service1'),
        ).called(1);
        verifyNoMoreInteractions(mockDriverRepository);
      },
    );
  });
}

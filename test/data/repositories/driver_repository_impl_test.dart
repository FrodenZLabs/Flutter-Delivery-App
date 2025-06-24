import 'package:flutter_delivery_app/data/models/driver/driver_model.dart';
import 'package:flutter_delivery_app/data/repositories_impl/driver_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late DriverRepositoryImpl repository;
  late MockDriverRemoteDataSource mockRemote;

  final driverModel = DriverModel(
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
    mockRemote = MockDriverRemoteDataSource();
    repository = DriverRepositoryImpl(mockRemote);
  });

  group('getDriverById', () {
    test(
      'should return driver when remote data source returns driver',
      () async {
        when(
          mockRemote.getDriverById('driver1'),
        ).thenAnswer((_) async => driverModel);

        final result = await repository.getDriverById('driver1');

        expect(result, driverModel);
        verify(mockRemote.getDriverById('driver1')).called(1);
        verifyNoMoreInteractions(mockRemote);
      },
    );
  });

  group('getDriversByServiceId', () {
    test('should return list of drivers for serviceId', () async {
      when(
        mockRemote.getDriversByServiceId('service1'),
      ).thenAnswer((_) async => [driverModel]);

      final result = await repository.getDriversByServiceId('service1');

      expect(result, isA<List<DriverModel>>());
      expect(result.length, 1);
      expect(result.first, driverModel);
      verify(mockRemote.getDriversByServiceId('service1')).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}

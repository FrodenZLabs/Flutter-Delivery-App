import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_delivery_app/domain/entities/driver/driver.dart';
import 'package:flutter_delivery_app/presentation/blocs/driver/driver_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late DriverBloc driverBloc;
  late MockDriverRepository mockDriverRepository;

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
    driverBloc = DriverBloc(mockDriverRepository);
  });

  tearDown(() => driverBloc.close());

  group('DriverBloc', () {
    blocTest<DriverBloc, DriverState>(
      'emits [Loading, DriversLoaded] when GetDriversByServiceIdEvent succeeds',
      build: () {
        when(
          mockDriverRepository.getDriversByServiceId('service1'),
        ).thenAnswer((_) async => [driver]);
        return driverBloc;
      },
      act: (bloc) => bloc.add(GetDriversByServiceIdEvent('service1')),
      expect: () => [
        DriverLoading(),
        DriversLoaded([driver]),
      ],
    );

    blocTest<DriverBloc, DriverState>(
      'emits [Loading, DriverLoaded] when GetDriverByIdEvent succeeds',
      build: () {
        when(
          mockDriverRepository.getDriverById('driver1'),
        ).thenAnswer((_) async => driver);
        return driverBloc;
      },
      act: (bloc) => bloc.add(GetDriverByIdEvent('driver1')),
      expect: () => [DriverLoading(), DriverLoaded(driver)],
    );

    blocTest<DriverBloc, DriverState>(
      'emits [Loading, DriverError] when GetDriverByIdEvent fails',
      build: () {
        when(
          mockDriverRepository.getDriverById('driver1'),
        ).thenThrow(Exception('Error'));
        return driverBloc;
      },
      act: (bloc) => bloc.add(GetDriverByIdEvent('driver1')),
      expect: () => [DriverLoading(), isA<DriverError>()],
    );

    blocTest<DriverBloc, DriverState>(
      'emits [Loading, DriverError] when driver is null',
      build: () {
        when(
          mockDriverRepository.getDriverById('driverX'),
        ).thenAnswer((_) async => null);
        return driverBloc;
      },
      act: (bloc) => bloc.add(GetDriverByIdEvent('driverX')),
      expect: () => [DriverLoading(), DriverError('Driver not found')],
    );
  });
}

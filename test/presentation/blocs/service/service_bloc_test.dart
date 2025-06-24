import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_all_services.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_by_id.dart';
import 'package:flutter_delivery_app/domain/usecases/service/search_services.dart';
import 'package:flutter_delivery_app/presentation/blocs/service/service_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockServiceRepository mockRepository;
  late GetAllServices getAllServices;
  late GetServiceById getServiceById;
  late SearchServices searchServices;
  late ServiceBloc bloc;

  final testService = Service(
    id: '1',
    name: 'Dry Cleaning',
    subName: 'Expert Dry Cleaning',
    description: 'Best dry cleaning services',
    imageUrl: 'http://image.com/dry.jpg',
    baseFee: 300,
    perKmFee: 50,
    available: true,
    openDay: 'Monday',
    closeDay: 'Friday',
    openTime: '8:00 AM',
    closeTime: '5:00 PM',
  );

  setUp(() {
    mockRepository = MockServiceRepository();
    getAllServices = GetAllServices(mockRepository);
    getServiceById = GetServiceById(mockRepository);
    searchServices = SearchServices(mockRepository);

    bloc = ServiceBloc(
      getAllServices: getAllServices,
      getServiceById: getServiceById,
      searchServices: searchServices,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('LoadAllServices', () {
    blocTest<ServiceBloc, ServiceState>(
      'emits [ServiceLoading, ServiceLoaded] on success',
      build: () {
        when(
          mockRepository.getAllServices(),
        ).thenAnswer((_) async => [testService]);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAllServices()),
      expect: () => [
        ServiceLoading(),
        ServiceLoaded([testService]),
      ],
      verify: (_) {
        verify(mockRepository.getAllServices()).called(1);
      },
    );

    blocTest<ServiceBloc, ServiceState>(
      'emits [ServiceLoading, ServiceError] on failure',
      build: () {
        when(mockRepository.getAllServices()).thenThrow(Exception('Failed'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAllServices()),
      expect: () => [ServiceLoading(), isA<ServiceError>()],
    );
  });

  group('GetServiceById', () {
    blocTest<ServiceBloc, ServiceState>(
      'emits [ServiceLoading, ServiceDetailLoaded] on success',
      build: () {
        when(
          mockRepository.getServiceById('1'),
        ).thenAnswer((_) async => testService);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadGetServiceById('1')),
      expect: () => [ServiceLoading(), ServiceDetailLoaded(testService)],
    );

    blocTest<ServiceBloc, ServiceState>(
      'emits [ServiceLoading, ServiceError] when service is null',
      build: () {
        when(mockRepository.getServiceById('2')).thenAnswer((_) async => null);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadGetServiceById('2')),
      expect: () => [ServiceLoading(), ServiceError('Service not found')],
    );
  });

  group('SearchServices', () {
    blocTest<ServiceBloc, ServiceState>(
      'emits [ServiceLoading, ServiceLoaded] when search succeeds',
      build: () {
        when(
          mockRepository.searchServices('cleaning'),
        ).thenAnswer((_) async => [testService]);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadSearchServices('cleaning')),
      expect: () => [
        ServiceLoading(),
        ServiceLoaded([testService]),
      ],
    );

    blocTest<ServiceBloc, ServiceState>(
      'emits [ServiceLoading, ServiceError] when search fails',
      build: () {
        when(
          mockRepository.searchServices('xyz'),
        ).thenThrow(Exception('API error'));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadSearchServices('xyz')),
      expect: () => [ServiceLoading(), isA<ServiceError>()],
    );
  });
}

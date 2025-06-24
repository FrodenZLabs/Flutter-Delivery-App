import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:flutter_delivery_app/data/repositories_impl/service_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockServiceRemoteDataSource mockRemote;
  late MockServiceLocalDataSource mockLocal;
  late ServiceRepositoryImpl repository;

  setUp(() {
    mockRemote = MockServiceRemoteDataSource();
    mockLocal = MockServiceLocalDataSource();
    repository = ServiceRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  final serviceModel = ServiceModel(
    id: '1',
    name: 'Dry Cleaning',
    subName: 'Expert Dry Cleaning',
    description: 'We clean your clothes!',
    imageUrl: 'http://image.com/dry.jpg',
    baseFee: 300,
    perKmFee: 50,
    available: true,
    openDay: 'Monday',
    closeDay: 'Friday',
    openTime: '8:00 AM',
    closeTime: '5:00 PM',
  );

  final modelList = [serviceModel];

  group('getAllServices', () {
    test('should return remote data and cache it locally', () async {
      when(mockRemote.fetchRemoteServices()).thenAnswer((_) async => modelList);
      when(mockLocal.cacheServices(modelList)).thenAnswer((_) async {});

      final result = await repository.getAllServices();

      expect(result, modelList);
      verify(mockRemote.fetchRemoteServices());
      verify(mockLocal.cacheServices(modelList));
    });

    test('should return local data if remote fails', () async {
      when(mockRemote.fetchRemoteServices()).thenThrow(Exception());
      when(mockLocal.getCachedServices()).thenAnswer((_) async => modelList);

      final result = await repository.getAllServices();

      expect(result, modelList);
      verify(mockLocal.getCachedServices());
    });
  });
}

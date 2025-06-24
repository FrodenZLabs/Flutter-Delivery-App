import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/data/repositories_impl/delivery_info_repository_impl.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late DeliveryInfoRepository repository;
  late MockDeliveryInfoRemoteDataSource mockRemoteDataSource;
  late MockDeliveryInfoLocalDataSource mockLocalDataSource;

  final testModel = DeliveryInfoModel(
    id: '1',
    userId: 'user1',
    address: 'Test Street',
    city: 'Nairobi',
    contactNumber: '0700000000',
    isDefault: false,
  );

  setUp(() {
    mockRemoteDataSource = MockDeliveryInfoRemoteDataSource();
    mockLocalDataSource = MockDeliveryInfoLocalDataSource();

    repository = DeliveryInfoRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  group('DeliveryInfoRepository', () {
    test('should add delivery info using remote data source', () async {
      when(
        mockRemoteDataSource.addDeliveryInfo(testModel),
      ).thenAnswer((_) async => Future.value());

      await repository.addDeliveryInfo(testModel);

      verify(mockRemoteDataSource.addDeliveryInfo(testModel)).called(1);
    });

    test('should update delivery info using remote data source', () async {
      when(
        mockRemoteDataSource.updateDeliveryInfo(testModel),
      ).thenAnswer((_) async => Future.value());

      await repository.updateDeliveryInfo(testModel);

      verify(mockRemoteDataSource.updateDeliveryInfo(testModel)).called(1);
    });

    test('should delete delivery info using remote data source', () async {
      when(
        mockRemoteDataSource.deleteDeliveryInfo(testModel.id),
      ).thenAnswer((_) async => Future.value());

      await repository.deleteDeliveryInfo(testModel.id);

      verify(mockRemoteDataSource.deleteDeliveryInfo(testModel.id)).called(1);
    });

    test(
      'should fetch all delivery info from remote and sync with local',
      () async {
        when(
          mockRemoteDataSource.fetchAllDeliveryInfo(testModel.userId),
        ).thenAnswer((_) async => [testModel]);

        // Stub local fallback too (required by your repository implementation)
        when(
          mockLocalDataSource.getAllDeliveryInfo(testModel.userId),
        ).thenAnswer((_) async => [testModel]);

        final result = await repository.getAllDeliveryInfo(testModel.userId);

        expect(result, isA<List<DeliveryInfoModel>>());
        verify(
          mockRemoteDataSource.fetchAllDeliveryInfo(testModel.userId),
        ).called(1);
      },
    );

    test('should get all delivery info from local data source', () async {
      when(
        mockLocalDataSource.getAllDeliveryInfo(testModel.userId),
      ).thenAnswer((_) async => [testModel]);

      final result = await repository.getAllDeliveryInfo(testModel.userId);

      expect(result, isA<List<DeliveryInfoModel>>());
      expect(result.first.userId, equals(testModel.userId));
    });

    test('should set default delivery info locally', () async {
      when(
        mockLocalDataSource.setDefaultDeliveryInfo(testModel.id),
      ).thenAnswer((_) async => Future.value());

      await repository.setDefaultDeliveryInfo(testModel.id);

      verify(
        mockLocalDataSource.setDefaultDeliveryInfo(testModel.id),
      ).called(1);
    });

    test('should get default delivery info locally', () async {
      when(
        mockLocalDataSource.getDefaultDeliveryInfo(testModel.userId),
      ).thenAnswer((_) async => testModel);

      final result = await repository.getDefaultDeliveryInfo(testModel.userId);

      expect(result, equals(testModel));
    });
  });
}

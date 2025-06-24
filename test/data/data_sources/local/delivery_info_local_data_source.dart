import 'package:flutter_delivery_app/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late HiveDeliveryInfoLocalDataSource localDataSource;
  late MockBox<DeliveryInfoModel> mockBox;

  final testModel = DeliveryInfoModel(
    id: '1',
    userId: 'user1',
    address: 'Test Street',
    city: 'Nairobi',
    contactNumber: '0700000000',
    isDefault: false,
  );

  setUpAll(() {
    Hive.init('test_hive_path');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(DeliveryInfoModelAdapter());
    }
  });

  setUp(() {
    mockBox = MockBox<DeliveryInfoModel>();
    localDataSource = HiveDeliveryInfoLocalDataSource();
  });

  test('should cache delivery info', () async {
    await localDataSource.cacheDeliveryInfo(testModel);
    final box = await Hive.openBox<DeliveryInfoModel>('deliveryInfoBox');
    await box.clear(); // clear before test
    await box.put(testModel.id, testModel);
    expect(box.get(testModel.id), testModel);
  });

  test('should update delivery info', () async {
    await localDataSource.updateDeliveryInfo(testModel);
    final box = await Hive.openBox<DeliveryInfoModel>('deliveryInfoBox');
    expect(await box.get(testModel.id), isA<DeliveryInfoModel>());
  });

  test('should delete delivery info', () async {
    final box = await Hive.openBox<DeliveryInfoModel>('deliveryInfoBox');
    await box.put(testModel.id, testModel);
    await localDataSource.deleteDeliveryInfo(testModel.id);
    expect(box.get(testModel.id), null);
  });

  test('should get all delivery info for user', () async {
    final box = await Hive.openBox<DeliveryInfoModel>('deliveryInfoBox');
    await box.clear();
    await box.put(testModel.id, testModel);
    final result = await localDataSource.getAllDeliveryInfo('user1');
    expect(result.length, 1);
    expect(result.first.userId, 'user1');
  });

  test('should set default delivery info', () async {
    final box = await Hive.openBox<DeliveryInfoModel>('deliveryInfoBox');
    await box.put(testModel.id, testModel);
    await localDataSource.setDefaultDeliveryInfo(testModel.id);

    final updated = await box.get(testModel.id);
    expect(updated?.isDefault, true);
  });

  test('should get default delivery info or fallback', () async {
    final box = await Hive.openBox<DeliveryInfoModel>('deliveryInfoBox');
    await box.clear();
    await box.put(testModel.id, testModel);

    final result = await localDataSource.getDefaultDeliveryInfo('user1');
    expect(result, isA<DeliveryInfoModel>());
  });
}

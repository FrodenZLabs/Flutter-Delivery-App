import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class DeliveryInfoLocalDataSource {
  Future<void> cacheDeliveryInfo(DeliveryInfoModel info);
  Future<void> updateDeliveryInfo(DeliveryInfoModel info);
  Future<void> deleteDeliveryInfo(String id);
  Future<List<DeliveryInfoModel>> getAllDeliveryInfo(String userId);
  Future<void> setDefaultDeliveryInfo(String id);
  Future<DeliveryInfoModel?> getDefaultDeliveryInfo(String userId);
  Future<void> syncAllDeliveryInfo(List<DeliveryInfoModel> infos);
}

@LazySingleton(as: DeliveryInfoLocalDataSource)
class HiveDeliveryInfoLocalDataSource implements DeliveryInfoLocalDataSource {
  static const String boxName = 'deliveryInfoBox';

  Future<Box<DeliveryInfoModel>> _openBox() =>
      Hive.openBox<DeliveryInfoModel>(boxName);

  @override
  Future<void> cacheDeliveryInfo(DeliveryInfoModel info) async {
    final box = await _openBox();
    await box.put(info.id, info);
  }

  @override
  Future<void> updateDeliveryInfo(DeliveryInfoModel info) async {
    final box = await _openBox();
    await box.put(info.id, info);
  }

  @override
  Future<void> deleteDeliveryInfo(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  @override
  Future<List<DeliveryInfoModel>> getAllDeliveryInfo(String userId) async {
    final box = await _openBox();
    return box.values.where((e) => e.userId == userId).toList();
  }

  @override
  Future<void> setDefaultDeliveryInfo(String id) async {
    final box = await _openBox();
    for (var key in box.keys) {
      final info = box.get(key);
      if (info != null) {
        await box.put(key, info.copyWith(isDefault: info.id == id));
      }
    }
  }

  @override
  Future<DeliveryInfoModel?> getDefaultDeliveryInfo(String userId) async {
    final box = await _openBox();

    final defaultInfos = box.values.where(
      (info) => info.userId == userId && info.isDefault,
    );

    if (defaultInfos.isNotEmpty) return defaultInfos.first;

    final allInfos = box.values.where((info) => info.userId == userId);

    return allInfos.isNotEmpty ? allInfos.first : null;
  }

  @override
  Future<void> syncAllDeliveryInfo(List<DeliveryInfoModel> infos) async {
    final box = await _openBox();

    // Remove all existing delivery info entries for the user(s)
    final userIds = infos.map((e) => e.userId).toSet();

    final keysToDelete = box.keys.where((key) {
      final info = box.get(key);
      return info != null && userIds.contains(info.userId);
    }).toList();

    await box.deleteAll(keysToDelete);

    // Insert all fetched entries
    for (final info in infos) {
      await box.put(info.id, info);
    }
  }
}

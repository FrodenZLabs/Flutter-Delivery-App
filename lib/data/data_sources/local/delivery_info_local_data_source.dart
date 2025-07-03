import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class DeliveryInfoLocalDataSource {
  Future<List<DeliveryInfoModel>> getDeliveryInfo();
  Future<DeliveryInfoModel?> getSelectedDeliveryInfo();
  Future<void> saveDeliveryInfo(List<DeliveryInfoModel> params);
  Future<void> updateDeliveryInfo(DeliveryInfoModel params);
  Future<void> updateSelectedDeliveryInfo(DeliveryInfoModel params);
  Future<void> clearDeliveryInfo();
}

@LazySingleton(as: DeliveryInfoLocalDataSource)
class HiveDeliveryInfoLocalDataSource implements DeliveryInfoLocalDataSource {
  static const String _boxName = 'delivery_info_box';
  static const String _selectedIdBox = 'selected_delivery_info_box';
  static const String _selectedIdKey = 'selected_id';

  Future<Box<DeliveryInfoModel>> _openBox() async {
    return await Hive.openBox<DeliveryInfoModel>(_boxName);
  }

  Future<Box<String>> _openSelectedIdBox() async {
    return await Hive.openBox<String>(_selectedIdBox);
  }

  @override
  Future<void> clearDeliveryInfo() async {
    final box = await _openBox();
    await box.clear();

    final selectedIdBox = await _openSelectedIdBox();
    await selectedIdBox.delete(_selectedIdKey);
  }

  @override
  Future<List<DeliveryInfoModel>> getDeliveryInfo() async {
    final box = await _openBox();
    return box.values.toList();
  }

  @override
  Future<DeliveryInfoModel?> getSelectedDeliveryInfo() async {
    final box = await _openBox();
    final selectedIdBox = await _openSelectedIdBox();
    final selectedId = selectedIdBox.get(_selectedIdKey);

    if (selectedId == null) {
      return null; // Or throw CacheFailure() if you want
    }

    return box.get(selectedId);
  }

  @override
  Future<void> saveDeliveryInfo(List<DeliveryInfoModel> params) async {
    final box = await _openBox();
    await box.clear();
    for (var deliveryInfo in params) {
      await box.put(deliveryInfo.id, deliveryInfo);
    }
  }

  @override
  Future<void> updateDeliveryInfo(DeliveryInfoModel params) async {
    final box = await _openBox();
    await box.put(params.id, params);
  }

  @override
  Future<void> updateSelectedDeliveryInfo(DeliveryInfoModel params) async {
    final box = await _openBox();
    await box.put(params.id, params);

    final selectedIdBox = await _openSelectedIdBox();
    await selectedIdBox.put(_selectedIdKey, params.id);
  }
}

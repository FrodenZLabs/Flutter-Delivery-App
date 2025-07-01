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

  Future<Box<DeliveryInfoModel>> _openBox() async {
    return await Hive.openBox<DeliveryInfoModel>(_boxName);
  }

  @override
  Future<List<DeliveryInfoModel>> getDeliveryInfo() async {
    final box = await _openBox();
    return box.values.toList();
  }

  @override
  Future<DeliveryInfoModel?> getSelectedDeliveryInfo() async {
    final box = await _openBox();
    final defaultItems = box.values.where((element) => element.isDefault);
    return defaultItems.isNotEmpty ? defaultItems.first : null;
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

    // Unset all as default first
    final allItems = box.values.toList();
    for (var item in allItems) {
      if (item.isDefault && item.id != params.id) {
        await box.put(item.id, item.copyWith(isDefault: false));
      }
    }

    // Set the selected one as default
    await box.put(params.id, params.copyWith(isDefault: true));
  }

  @override
  Future<void> clearDeliveryInfo() async {
    final box = await _openBox();
    await box.clear();
  }
}

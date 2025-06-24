import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';

abstract class DeliveryInfoRepository {
  Future<void> addDeliveryInfo(DeliveryInfo info);
  Future<void> updateDeliveryInfo(DeliveryInfo info);
  Future<void> deleteDeliveryInfo(String id);
  Future<List<DeliveryInfo>> getAllDeliveryInfo(String userId);
  Future<void> setDefaultDeliveryInfo(String id);
  Future<DeliveryInfo?> getDefaultDeliveryInfo(String userId);
}

import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDefaultDeliveryInfo {
  final DeliveryInfoRepository repository;
  GetDefaultDeliveryInfo(this.repository);

  Future<DeliveryInfo?> call(String userId) =>
      repository.getDefaultDeliveryInfo(userId);
}

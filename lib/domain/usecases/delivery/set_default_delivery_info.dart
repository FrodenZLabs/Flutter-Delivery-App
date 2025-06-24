import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetDefaultDeliveryInfo {
  final DeliveryInfoRepository repository;
  SetDefaultDeliveryInfo(this.repository);

  Future<void> call(String id) => repository.setDefaultDeliveryInfo(id);
}

import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteDeliveryInfo {
  final DeliveryInfoRepository repository;
  DeleteDeliveryInfo(this.repository);

  Future<void> call(String id) => repository.deleteDeliveryInfo(id);
}

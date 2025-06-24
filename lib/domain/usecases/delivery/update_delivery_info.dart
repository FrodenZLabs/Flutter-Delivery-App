import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateDeliveryInfo {
  final DeliveryInfoRepository repository;
  UpdateDeliveryInfo(this.repository);

  Future<void> call(DeliveryInfo info) => repository.updateDeliveryInfo(info);
}

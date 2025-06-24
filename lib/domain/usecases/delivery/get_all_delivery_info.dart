import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllDeliveryInfo {
  final DeliveryInfoRepository repository;
  GetAllDeliveryInfo(this.repository);

  Future<List<DeliveryInfo>> call(String userId) =>
      repository.getAllDeliveryInfo(userId);
}

import 'package:flutter_delivery_app/domain/entities/driver/driver.dart';
import 'package:flutter_delivery_app/domain/repositories/driver/driver_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDriversByServiceId {
  final DriverRepository repository;

  GetDriversByServiceId(this.repository);

  Future<List<Driver>> call(String serviceId) {
    return repository.getDriversByServiceId(serviceId);
  }
}

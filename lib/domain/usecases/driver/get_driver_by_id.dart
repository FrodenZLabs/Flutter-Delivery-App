import 'package:flutter_delivery_app/domain/entities/driver/driver.dart';
import 'package:flutter_delivery_app/domain/repositories/driver/driver_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDriverById {
  final DriverRepository repository;

  GetDriverById(this.repository);

  Future<Driver?> call(String driverId) {
    return repository.getDriverById(driverId);
  }
}

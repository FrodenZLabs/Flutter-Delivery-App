import 'package:flutter_delivery_app/domain/entities/driver/driver.dart';

abstract class DriverRepository {
  Future<List<Driver>> getDriversByServiceId(String serviceId);
  Future<Driver?> getDriverById(String driverId); // optional
}

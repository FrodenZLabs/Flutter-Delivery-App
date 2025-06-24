import 'package:flutter_delivery_app/data/data_sources/remote/driver_remote_data_source.dart';
import 'package:flutter_delivery_app/domain/entities/driver/driver.dart';
import 'package:flutter_delivery_app/domain/repositories/driver/driver_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DriverRepository)
class DriverRepositoryImpl implements DriverRepository {
  final DriverRemoteDataSource remoteDataSource;

  DriverRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Driver>> getDriversByServiceId(String serviceId) async {
    final models = await remoteDataSource.getDriversByServiceId(serviceId);
    return models;
  }

  @override
  Future<Driver?> getDriverById(String driverId) {
    return remoteDataSource.getDriverById(driverId);
  }
}

import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class ServiceLocalDataSource {
  Future<void> cacheServices(List<ServiceModel> services);
  Future<List<ServiceModel>> getCachedServices();
}

@LazySingleton(as: ServiceLocalDataSource)
class HiveServiceLocalDataSource implements ServiceLocalDataSource {
  final Box<ServiceModel> box;

  HiveServiceLocalDataSource(this.box);

  @override
  Future<void> cacheServices(List<ServiceModel> services) async {
    await box.clear();
    for (var service in services) {
      await box.put(service.id, service);
    }
  }

  @override
  Future<List<ServiceModel>> getCachedServices() async {
    return box.values.toList();
  }
}

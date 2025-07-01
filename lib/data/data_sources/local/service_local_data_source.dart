import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:flutter_delivery_app/data/models/service/service_response_model.dart';
import 'package:flutter_delivery_app/domain/entities/service/pagination_meta_data.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class ServiceLocalDataSource {
  Future<void> cacheServices(ServiceResponseModel servicesToCache);
  Future<ServiceResponseModel> getCachedServices();
}

@LazySingleton(as: ServiceLocalDataSource)
class HiveServiceLocalDataSource implements ServiceLocalDataSource {
  final Box<ServiceModel> box;

  HiveServiceLocalDataSource(this.box);

  @override
  Future<void> cacheServices(ServiceResponseModel servicesToCache) async {
    await box.clear();
    for (var service in servicesToCache.service) {
      if (service is ServiceModel) {
        await box.put(service.id, service);
      }
    }
  }

  @override
  Future<ServiceResponseModel> getCachedServices() async {
    final cachedServices = box.values.toList();

    return ServiceResponseModel(
      meta: PaginationMetaData(
        limit: cachedServices.length,
        pageSize: cachedServices.length,
        total: cachedServices.length,
      ),
      data: cachedServices,
    );
  }
}

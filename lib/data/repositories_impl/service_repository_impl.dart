import 'package:collection/collection.dart';
import 'package:flutter_delivery_app/data/data_sources/local/service_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/service_remote_data_source.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ServiceRepository)
class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;
  final ServiceLocalDataSource localDataSource;

  ServiceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Service>> getAllServices() async {
    try {
      final remoteServices = await remoteDataSource.fetchRemoteServices();
      await localDataSource.cacheServices(remoteServices);
      return remoteServices;
    } catch (e) {
      return await localDataSource.getCachedServices();
    }
  }

  @override
  Future<Service?> getServiceById(String id) async {
    try {
      final remote = await remoteDataSource.fetchServiceById(id);
      return remote;
    } catch (_) {
      final local = await localDataSource.getCachedServices();
      return local.firstWhereOrNull((s) => s.id == id);
    }
  }

  @override
  Future<List<Service>> searchServices(String keyword) async {
    try {
      return await remoteDataSource.searchServices(keyword);
    } catch (_) {
      final local = await localDataSource.getCachedServices();
      return local
          .where(
            (s) =>
                s.name.toLowerCase().contains(keyword.toLowerCase()) ||
                s.subName.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
    }
  }
}

import 'package:flutter_delivery_app/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeliveryInfoRepository)
class DeliveryInfoRepositoryImpl implements DeliveryInfoRepository {
  final DeliveryInfoRemoteDataSource remote;
  final DeliveryInfoLocalDataSource local;

  DeliveryInfoRepositoryImpl(this.remote, this.local);

  @override
  Future<void> addDeliveryInfo(DeliveryInfo info) async {
    final model = info as DeliveryInfoModel;
    await remote.addDeliveryInfo(model);
    await local.cacheDeliveryInfo(model);
  }

  @override
  Future<void> updateDeliveryInfo(DeliveryInfo info) async {
    final model = info as DeliveryInfoModel;
    await remote.updateDeliveryInfo(model);
    await local.updateDeliveryInfo(model);
  }

  @override
  Future<void> deleteDeliveryInfo(String id) async {
    await remote.deleteDeliveryInfo(id);
    await local.deleteDeliveryInfo(id);
  }

  @override
  Future<List<DeliveryInfo>> getAllDeliveryInfo(String userId) async {
    try {
      final remoteList = await remote.fetchAllDeliveryInfo(userId);
      // sync done internally by remote data source
      return await local.getAllDeliveryInfo(userId);
    } catch (_) {
      return await local.getAllDeliveryInfo(userId); // fallback
    }
  }

  @override
  Future<void> setDefaultDeliveryInfo(String id) async {
    await local.setDefaultDeliveryInfo(id);
  }

  @override
  Future<DeliveryInfo?> getDefaultDeliveryInfo(String userId) {
    return local.getDefaultDeliveryInfo(userId);
  }
}

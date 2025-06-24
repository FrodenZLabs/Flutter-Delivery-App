import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetServiceById {
  final ServiceRepository repository;

  GetServiceById(this.repository);

  Future<Service?> call(String id) async {
    return await repository.getServiceById(id);
  }
}

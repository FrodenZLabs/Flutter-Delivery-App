import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllServices {
  final ServiceRepository repository;

  GetAllServices(this.repository);

  Future<List<Service>> call() async {
    return await repository.getAllServices();
  }
}

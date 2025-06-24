import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchServices {
  final ServiceRepository repository;

  SearchServices(this.repository);

  Future<List<Service>> call(String keyword) async {
    return await repository.searchServices(keyword);
  }
}

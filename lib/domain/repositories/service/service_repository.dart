import 'package:flutter_delivery_app/domain/entities/service/service.dart';

abstract class ServiceRepository {
  /// Fetch all available services
  Future<List<Service>> getAllServices();

  /// Fetch a single service by its ID
  Future<Service?> getServiceById(String id);

  /// Search for services by keyword
  Future<List<Service>> searchServices(String keyword);
}

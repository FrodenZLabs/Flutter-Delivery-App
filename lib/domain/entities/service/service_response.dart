import 'package:flutter_delivery_app/domain/entities/service/pagination_meta_data.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';

class ServiceResponse {
  final List<Service> service;
  final PaginationMetaData paginationMetaData;

  ServiceResponse({required this.service, required this.paginationMetaData});
}

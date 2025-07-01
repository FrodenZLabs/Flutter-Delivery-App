import 'dart:convert';

import 'package:flutter_delivery_app/data/models/service/pagination_data_model.dart';
import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:flutter_delivery_app/domain/entities/service/pagination_meta_data.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/entities/service/service_response.dart';

ServiceResponseModel serviceResponseModelFromJson(String str) =>
    ServiceResponseModel.fromJson(json.decode(str));

String serviceResponseModelToJson(ServiceResponseModel data) =>
    json.encode(data.toJson());

class ServiceResponseModel extends ServiceResponse {
  ServiceResponseModel({
    required PaginationMetaData meta,
    required List<Service> data,
  }) : super(service: data, paginationMetaData: meta);

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceResponseModel(
      meta: PaginationMetaDataModel.fromJson(json['meta']),
      data: List<ServiceModel>.from(
        json['data'].map((x) => ServiceModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "meta": paginationMetaData,
    "data": List<dynamic>.from(
      (service as List<ServiceModel>).map((x) => x.toJson()),
    ),
  };
}

import 'dart:convert';

import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:hive/hive.dart';

part 'delivery_info_model.g.dart';

DeliveryInfoModel deliveryInfoModelFromRemoteJson(String str) {
  final Map<String, dynamic> jsonResponse = json.decode(str);
  return DeliveryInfoModel.fromJson(jsonResponse['data']);
}

DeliveryInfoModel deliveryInfoModelFromLocalJson(String str) =>
    DeliveryInfoModel.fromJson(json.decode(str));
List<DeliveryInfoModel> deliveryInfoModelListFromRemoteJson(String str) {
  final decoded = json.decode(str);
  final List<dynamic> dataList = decoded['data'];
  return dataList.map((x) => DeliveryInfoModel.fromJson(x)).toList();
}

List<DeliveryInfoModel> deliveryInfoModelListFromLocalJson(String str) =>
    List<DeliveryInfoModel>.from(
      json.decode(str).map((x) => DeliveryInfoModel.fromJson(x)),
    );
String deliveryInfoModelToJson(DeliveryInfoModel data) =>
    json.encode(data.toJson());
String deliveryInfoModelListToJson(List<DeliveryInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class DeliveryInfoModel extends DeliveryInfo {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String userId;

  @HiveField(2)
  @override
  final String address;

  @HiveField(3)
  @override
  final String city;

  @HiveField(4)
  @override
  final String contactNumber;

  const DeliveryInfoModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.city,
    required this.contactNumber,
  }) : super(
         id: id,
         userId: userId,
         address: address,
         city: city,
         contactNumber: contactNumber,
       );

  factory DeliveryInfoModel.fromJson(Map<String, dynamic> json) {
    return DeliveryInfoModel(
      id: json['_id'],
      userId: json['userId'],
      address: json['address'],
      city: json['city'],
      contactNumber: json['contactNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'address': address,
    'city': city,
    'contactNumber': contactNumber,
  };

  DeliveryInfoModel copyWith({
    String? id,
    String? userId,
    String? address,
    String? city,
    String? contactNumber,
  }) {
    return DeliveryInfoModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      address: address ?? this.address,
      city: city ?? this.city,
      contactNumber: contactNumber ?? this.contactNumber,
    );
  }

  factory DeliveryInfoModel.fromEntity(DeliveryInfo entity) =>
      DeliveryInfoModel(
        id: entity.id,
        userId: entity.userId,
        address: entity.address,
        city: entity.city,
        contactNumber: entity.contactNumber,
      );
}

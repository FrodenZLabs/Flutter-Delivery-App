import 'dart:convert';

import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:hive/hive.dart';

part 'service_model.g.dart';

// ✅ Single ServiceModel from JSON string (for one service, if needed)
ServiceModel serviceModelFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

// ✅ Single ServiceModel to JSON string
String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

// ✅ List<ServiceModel> from JSON string (when backend returns list like your /services endpoint)
List<ServiceModel> serviceModelListFromJson(String str) =>
    List<ServiceModel>.from(
      json.decode(str)['data'].map((x) => ServiceModel.fromJson(x)),
    );

// ✅ Convert List<ServiceModel> to JSON string (if you ever want to cache/save locally)
String serviceModelListToJson(List<ServiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class ServiceModel extends Service {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String subName;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final double baseFee;

  @HiveField(6)
  final double perKmFee;

  @HiveField(7)
  final bool available;

  @HiveField(8)
  final String openDay;

  @HiveField(9)
  final String closeDay;

  @HiveField(10)
  final String openTime;

  @HiveField(11)
  final String closeTime;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.subName,
    required this.description,
    required this.imageUrl,
    required this.baseFee,
    required this.perKmFee,
    required this.available,
    required this.openDay,
    required this.closeDay,
    required this.openTime,
    required this.closeTime,
  }) : super(
         id: id,
         name: name,
         subName: subName,
         description: description,
         imageUrl: imageUrl,
         baseFee: baseFee,
         perKmFee: perKmFee,
         available: available,
         openDay: openDay,
         closeDay: closeDay,
         openTime: openTime,
         closeTime: closeTime,
       );

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json['id'],
    name: json['name'],
    subName: json['subName'],
    description: json['description'],
    imageUrl: json['imageUrl'],
    baseFee: (json['baseFee'] as num).toDouble(),
    perKmFee: (json['perKmFee'] as num).toDouble(),
    available: json['available'],
    openDay: json['openDay'],
    closeDay: json['closeDay'],
    openTime: json['openTime'],
    closeTime: json['closeTime'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'subName': subName,
    'description': description,
    'imageUrl': imageUrl,
    'baseFee': baseFee,
    'perKmFee': perKmFee,
    'available': available,
    'openDay': openDay,
    'closeDay': closeDay,
    'openTime': openTime,
    'closeTime': closeTime,
  };
}

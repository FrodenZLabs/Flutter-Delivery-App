import 'dart:convert';

import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:hive/hive.dart';

part 'schedule_model.g.dart';

ScheduleModel scheduleModelFromRemoteJson(String str) {
  final Map<String, dynamic> jsonResponse = json.decode(str);
  return ScheduleModel.fromJson(jsonResponse['data']);
}

List<ScheduleModel> scheduleModelListFromRemoteJson(String str) {
  final decoded = json.decode(str);
  final List<dynamic> dataList = decoded['data'];
  return dataList.map((x) => ScheduleModel.fromJson(x)).toList();
}

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

@HiveType(typeId: 3)
class ScheduleModel extends Schedule {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String userId;

  @HiveField(2)
  @override
  final String serviceId;

  @HiveField(3)
  @override
  final String deliveryInfoId;

  @HiveField(4)
  @override
  final DateTime scheduleDate;

  @HiveField(5)
  @override
  final String scheduleTime;

  @HiveField(6)
  @override
  final String status;

  @HiveField(7)
  final String? driverId;

  @HiveField(8)
  final String? driverName;

  @HiveField(9)
  final String? driverImage;

  @HiveField(10)
  final String? driverContact;

  @HiveField(11)
  final String? vehicleInfo;

  @HiveField(12)
  final String name;

  @HiveField(13)
  final String subname;

  @HiveField(14)
  final String imageUrl;

  @HiveField(15)
  final String address;

  @HiveField(16)
  final String city;

  @HiveField(17)
  final String contact;

  ScheduleModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.deliveryInfoId,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
    this.driverId,
    this.driverName,
    this.driverImage,
    this.driverContact,
    this.vehicleInfo,
    required this.name,
    required this.subname,
    required this.imageUrl,
    required this.address,
    required this.city,
    required this.contact,
  }) : super(
         id: id,
         userId: userId,
         serviceId: serviceId,
         deliveryInfoId: deliveryInfoId,
         scheduleDate: scheduleDate,
         scheduleTime: scheduleTime,
         status: status,
       );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    final driver = json['driverId'];
    final service = json['serviceId'];
    final deliveryInfo = json['deliveryInfoId'];

    return ScheduleModel(
      id: json['_id'],
      userId: json['userId'],
      serviceId: service['_id'],
      name: service['name'],
      subname: service['subname'],
      imageUrl: service['imageUrl'],
      deliveryInfoId: deliveryInfo['_id'],
      address: deliveryInfo['address'],
      city: deliveryInfo['city'],
      contact: deliveryInfo['contactNumber'],
      scheduleDate: DateTime.parse(json['scheduleDate']),
      scheduleTime: json['scheduleTime'],
      status: json['status'],
      driverId: driver != null ? driver['_id'] : null,
      driverName: driver != null
          ? "${driver['firstName']} ${driver['lastName']}"
          : null,
      driverImage: driver != null ? driver['profilePictureUrl'] : null,
      driverContact: driver != null ? driver['contactNumber'] : null,
      vehicleInfo: driver != null ? driver['vehicleType'] : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'serviceId': serviceId,
    'name': name,
    'subname': subname,
    'imageUrl': imageUrl,
    'deliveryInfoId': deliveryInfoId,
    'address': address,
    'city': city,
    'contact': contact,
    'scheduleDate': scheduleDate.toIso8601String(),
    'scheduleTime': scheduleTime,
    'status': status,
    'driverId': driverId,
    'driverName': driverName,
    'driverImage': driverImage,
    'driverContact': driverContact,
    'vehicleInfo': vehicleInfo,
  };

  ScheduleModel copyWith({
    String? id,
    String? userId,
    String? serviceId,
    String? name,
    String? subname,
    String? imageUrl,
    String? deliveryInfoId,
    DateTime? scheduleDate,
    String? scheduleTime,
    String? status,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      serviceId: serviceId ?? this.serviceId,
      deliveryInfoId: deliveryInfoId ?? this.deliveryInfoId,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      scheduleTime: scheduleTime ?? this.scheduleTime,
      status: status ?? this.status,
      name: name ?? this.name,
      subname: subname ?? this.subname,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address,
      city: city,
      contact: contact,
    );
  }
}

import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:hive/hive.dart';

part 'schedule_model.g.dart';

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

  ScheduleModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.deliveryInfoId,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
  }) : super(
         id: id,
         userId: userId,
         serviceId: serviceId,
         deliveryInfoId: deliveryInfoId,
         scheduleDate: scheduleDate,
         scheduleTime: scheduleTime,
         status: status,
       );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json['id'],
    userId: json['userId'],
    serviceId: json['serviceId'],
    deliveryInfoId: json['deliveryInfoId'],
    scheduleDate: DateTime.parse(json['scheduleDate']),
    scheduleTime: json['scheduleTime'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'serviceId': serviceId,
    'deliveryInfoId': deliveryInfoId,
    'scheduleDate': scheduleDate.toIso8601String(),
    'scheduleTime': scheduleTime,
    'status': status,
  };

  ScheduleModel copyWith({
    String? id,
    String? userId,
    String? serviceId,
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
    );
  }
}

import 'package:flutter_delivery_app/domain/entities/driver/driver.dart';

class DriverModel extends Driver {
  DriverModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.licensePlate,
    required super.vehicleType,
    required super.contactNumber,
    required super.profilePictureUrl,
    required super.serviceId,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? '',
      serviceId: json['serviceId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      licensePlate: json['licensePlate'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'serviceId': serviceId,
    'firstName': firstName,
    'lastName': lastName,
    'contactNumber': contactNumber,
    'licensePlate': licensePlate,
    'vehicleType': vehicleType,
    'profilePictureUrl': profilePictureUrl,
  };
}

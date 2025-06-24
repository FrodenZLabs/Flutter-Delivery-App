import 'package:equatable/equatable.dart';

class DeliveryInfo extends Equatable {
  final String id;
  final String userId;
  final String address;
  final String city;
  final String contactNumber;
  final bool isDefault;

  const DeliveryInfo({
    required this.id,
    required this.userId,
    required this.address,
    required this.city,
    required this.contactNumber,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    address,
    city,
    contactNumber,
    isDefault,
  ];
}

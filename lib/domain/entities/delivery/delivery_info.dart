import 'package:equatable/equatable.dart';

class DeliveryInfo extends Equatable {
  final String id;
  final String userId;
  final String address;
  final String city;
  final String contactNumber;

  const DeliveryInfo({
    required this.id,
    required this.userId,
    required this.address,
    required this.city,
    required this.contactNumber,
  });

  @override
  List<Object?> get props => [id, userId, address, city, contactNumber];
}

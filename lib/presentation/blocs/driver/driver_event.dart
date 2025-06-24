part of 'driver_bloc.dart';

abstract class DriverEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDriversByServiceIdEvent extends DriverEvent {
  final String serviceId;

  GetDriversByServiceIdEvent(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}

class GetDriverByIdEvent extends DriverEvent {
  final String driverId;

  GetDriverByIdEvent(this.driverId);

  @override
  List<Object?> get props => [driverId];
}

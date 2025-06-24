part of 'driver_bloc.dart';

abstract class DriverState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriversLoaded extends DriverState {
  final List<Driver> drivers;

  DriversLoaded(this.drivers);

  @override
  List<Object?> get props => [drivers];
}

class DriverLoaded extends DriverState {
  final Driver driver;

  DriverLoaded(this.driver);

  @override
  List<Object?> get props => [driver];
}

class DriverError extends DriverState {
  final String message;

  DriverError(this.message);

  @override
  List<Object?> get props => [message];
}

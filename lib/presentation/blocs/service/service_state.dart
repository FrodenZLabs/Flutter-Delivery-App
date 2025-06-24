part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object?> get props => [];
}

final class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<Service> services;

  const ServiceLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class ServiceDetailLoaded extends ServiceState {
  final Service service;

  const ServiceDetailLoaded(this.service);

  @override
  List<Object> get props => [service];
}

class ServiceError extends ServiceState {
  final String message;

  const ServiceError(this.message);

  @override
  List<Object> get props => [message];
}

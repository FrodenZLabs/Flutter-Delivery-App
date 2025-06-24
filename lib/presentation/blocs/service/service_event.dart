part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllServices extends ServiceEvent {}

class LoadGetServiceById extends ServiceEvent {
  final String id;

  const LoadGetServiceById(this.id);

  @override
  List<Object> get props => [id];
}

class LoadSearchServices extends ServiceEvent {
  final String query;

  const LoadSearchServices(this.query);

  @override
  List<Object> get props => [query];
}

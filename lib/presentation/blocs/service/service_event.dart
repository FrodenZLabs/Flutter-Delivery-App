part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();
}

class LoadAllServices extends ServiceEvent {
  final FilterServiceParams params;
  const LoadAllServices(this.params);

  @override
  List<Object?> get props => [];
}

class LoadMoreServices extends ServiceEvent {
  const LoadMoreServices();

  @override
  List<Object?> get props => [];
}

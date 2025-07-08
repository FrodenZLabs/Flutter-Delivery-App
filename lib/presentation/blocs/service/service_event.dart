part of 'service_bloc.dart';

abstract class ServiceEvent {
  const ServiceEvent();
}

class LoadAllServices extends ServiceEvent {
  final FilterServiceParams params;
  const LoadAllServices(this.params);
}

class LoadMoreServices extends ServiceEvent {
  const LoadMoreServices();
}

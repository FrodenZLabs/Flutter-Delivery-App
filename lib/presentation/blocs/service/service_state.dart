part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  final List<Service> services;
  final PaginationMetaData metaData;
  final FilterServiceParams params;

  const ServiceState({
    required this.services,
    required this.metaData,
    required this.params,
  });
}

final class ServiceInitial extends ServiceState {
  const ServiceInitial({
    required super.services,
    required super.params,
    required super.metaData,
  });

  @override
  List<Object?> get props => [];
}

class ServiceLoading extends ServiceState {
  const ServiceLoading({
    required super.services,
    required super.params,
    required super.metaData,
  });

  @override
  List<Object?> get props => [];
}

class ServiceLoaded extends ServiceState {
  const ServiceLoaded({
    required super.services,
    required super.params,
    required super.metaData,
  });

  @override
  List<Object?> get props => [services];
}

class ServiceEmpty extends ServiceState {
  const ServiceEmpty({
    required super.services,
    required super.params,
    required super.metaData,
  });

  @override
  List<Object?> get props => [];
}

class ServiceError extends ServiceState {
  final Failure failure;

  const ServiceError({
    required super.services,
    required super.params,
    required this.failure,
    required super.metaData,
  });

  @override
  List<Object?> get props => [];
}

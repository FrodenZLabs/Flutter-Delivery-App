part of 'popular_service_bloc.dart';

abstract class PopularServicesState extends Equatable {
  const PopularServicesState();
}

class PopularServicesInitial extends PopularServicesState {
  const PopularServicesInitial();
  @override
  List<Object?> get props => [];
}

class PopularServicesLoading extends PopularServicesState {
  const PopularServicesLoading();
  @override
  List<Object?> get props => [];
}

class PopularServicesLoaded extends PopularServicesState {
  final List<Service> services;
  final PaginationMetaData metaData;

  const PopularServicesLoaded({required this.services, required this.metaData});

  @override
  List<Object?> get props => [services, metaData];
}

class PopularServicesError extends PopularServicesState {
  final Failure failure;

  const PopularServicesError({required this.failure});

  @override
  List<Object?> get props => [failure];
}

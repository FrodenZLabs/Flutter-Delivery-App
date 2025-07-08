part of 'popular_service_bloc.dart';

abstract class PopularServicesEvent extends Equatable {
  const PopularServicesEvent();
}

class LoadPopularServices extends PopularServicesEvent {
  final FilterServiceParams params;
  const LoadPopularServices(this.params);

  @override
  List<Object?> get props => [];
}

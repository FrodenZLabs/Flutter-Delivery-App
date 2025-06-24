part of 'delivery_info_bloc.dart';

abstract class DeliveryInfoState extends Equatable {
  const DeliveryInfoState();

  @override
  List<Object?> get props => [];
}

class DeliveryInfoInitial extends DeliveryInfoState {}

class DeliveryInfoLoading extends DeliveryInfoState {}

class DeliveryInfoLoaded extends DeliveryInfoState {
  final List<DeliveryInfo> infos;
  final DeliveryInfo? defaultInfo;

  const DeliveryInfoLoaded(this.infos, this.defaultInfo);

  @override
  List<Object?> get props => [infos, defaultInfo];
}

class DeliveryInfoError extends DeliveryInfoState {
  final String message;
  const DeliveryInfoError(this.message);

  @override
  List<Object?> get props => [message];
}

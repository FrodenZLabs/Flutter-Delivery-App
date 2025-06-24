part of 'delivery_info_bloc.dart';

abstract class DeliveryInfoEvent extends Equatable {
  const DeliveryInfoEvent();

  @override
  List<Object?> get props => [];
}

class LoadDeliveryInfosEvent extends DeliveryInfoEvent {
  final String userId;
  const LoadDeliveryInfosEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddDeliveryInfoEvent extends DeliveryInfoEvent {
  final DeliveryInfo info;
  const AddDeliveryInfoEvent(this.info);

  @override
  List<Object?> get props => [info];
}

class UpdateDeliveryInfoEvent extends DeliveryInfoEvent {
  final DeliveryInfo info;
  const UpdateDeliveryInfoEvent(this.info);

  @override
  List<Object?> get props => [info];
}

class DeleteDeliveryInfoEvent extends DeliveryInfoEvent {
  final String id;
  const DeleteDeliveryInfoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SetDefaultDeliveryInfoEvent extends DeliveryInfoEvent {
  final String id;
  final String userId;
  const SetDefaultDeliveryInfoEvent(this.id, this.userId);

  @override
  List<Object?> get props => [id, userId];
}

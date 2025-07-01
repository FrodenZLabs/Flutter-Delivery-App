import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/add_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/edit_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/select_delivery_info_use_case.dart';
import 'package:injectable/injectable.dart';

part 'delivery_info_action_state.dart';

@injectable
class DeliveryInfoActionCubit extends Cubit<DeliveryInfoActionState> {
  final AddDeliveryInfoUseCase _addDeliveryInfoUseCase;
  final EditDeliveryInfoUseCase _editDeliveryInfoUseCase;
  final SelectDeliveryInfoUseCase _selectDeliveryInfoUseCase;

  DeliveryInfoActionCubit(
    this._addDeliveryInfoUseCase,
    this._editDeliveryInfoUseCase,
    this._selectDeliveryInfoUseCase,
  ) : super(DeliveryInfoActionInitial());

  void addDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _addDeliveryInfoUseCase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoAddActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }

  void editDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _editDeliveryInfoUseCase(params);
      debugPrint("Delivery Info Cubit: $result");
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoEditActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      debugPrint("Error: $e");
      emit(DeliveryInfoActionFail());
    }
  }

  void selectDeliveryInfo(DeliveryInfo params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _selectDeliveryInfoUseCase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoSelectActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/delete_local_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/get_local_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/get_remote_delivery_info_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/get_selected_delivery_info_use_case.dart';
import 'package:injectable/injectable.dart';

part 'delivery_info_fetch_state.dart';

@injectable
class DeliveryInfoFetchCubit extends Cubit<DeliveryInfoFetchState> {
  final GetRemoteDeliveryInfoUseCase _getRemoteDeliveryInfoUseCase;
  final GetLocalDeliveryInfoUseCase _getLocalDeliveryInfoUseCase;
  final GetSelectedDeliveryInfoUseCase _getSelectedDeliveryInfoUseCase;
  final DeleteLocalDeliveryInfoUseCase _deleteLocalDeliveryInfoUseCase;

  DeliveryInfoFetchCubit(
    this._getRemoteDeliveryInfoUseCase,
    this._getLocalDeliveryInfoUseCase,
    this._getSelectedDeliveryInfoUseCase,
    this._deleteLocalDeliveryInfoUseCase,
  ) : super(const DeliveryInfoFetchInitial(deliveryInformation: []));

  void fetchDeliveryInfo() async {
    try {
      emit(
        DeliveryInfoFetchLoading(
          deliveryInformation: const [],
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
      final cachedResult = await _getLocalDeliveryInfoUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (deliveryInfo) => emit(
          DeliveryInfoFetchSuccess(
            deliveryInformation: deliveryInfo,
            selectedDeliveryInformation: state.selectedDeliveryInformation,
          ),
        ),
      );

      final selectedDeliveryInfo = await _getSelectedDeliveryInfoUseCase(
        NoParams(),
      );
      selectedDeliveryInfo.fold(
        (failure) => (),
        (deliveryInfo) => emit(
          DeliveryInfoFetchSuccess(
            deliveryInformation: state.deliveryInformation,
            selectedDeliveryInformation: deliveryInfo,
          ),
        ),
      );

      final result = await _getRemoteDeliveryInfoUseCase(NoParams());
      result.fold(
        (failure) => emit(
          DeliveryInfoFetchFail(deliveryInformation: state.deliveryInformation),
        ),
        (deliveryInfo) => emit(
          DeliveryInfoFetchSuccess(
            deliveryInformation: deliveryInfo,
            selectedDeliveryInformation: state.selectedDeliveryInformation,
          ),
        ),
      );
    } catch (e) {
      emit(
        DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
    }
  }

  void addDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(
        DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
      final value = state.deliveryInformation;
      value.add(deliveryInfo);
      emit(
        DeliveryInfoFetchSuccess(
          deliveryInformation: value,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
    } catch (e) {
      emit(
        DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
    }
  }

  void editDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(
        DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
      final value = state.deliveryInformation;
      value[value.indexWhere((element) => element == deliveryInfo)];
      emit(
        DeliveryInfoFetchSuccess(
          deliveryInformation: value,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
    } catch (e) {
      emit(
        DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
    }
  }

  void selectDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(
        DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
      emit(
        DeliveryInfoFetchSuccess(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: deliveryInfo,
        ),
      );
    } catch (e) {
      emit(
        DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
    }
  }

  void clearLocalDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(
        DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
      final cachedResult = await _deleteLocalDeliveryInfoUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (deliveryInfo) => emit(
          DeliveryInfoFetchSuccess(
            deliveryInformation: [],
            selectedDeliveryInformation: null,
          ),
        ),
      );
    } catch (e) {
      emit(
        DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        ),
      );
    }
  }
}

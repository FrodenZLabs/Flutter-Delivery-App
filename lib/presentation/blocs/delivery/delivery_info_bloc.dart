import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/add_delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/delete_delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/get_all_delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/get_default_delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/set_default_delivery_info.dart';
import 'package:flutter_delivery_app/domain/usecases/delivery/update_delivery_info.dart';
import 'package:injectable/injectable.dart';

part 'delivery_info_event.dart';
part 'delivery_info_state.dart';

@injectable
class DeliveryInfoBloc extends Bloc<DeliveryInfoEvent, DeliveryInfoState> {
  final AddDeliveryInfo addDeliveryInfo;
  final UpdateDeliveryInfo updateDeliveryInfo;
  final DeleteDeliveryInfo deleteDeliveryInfo;
  final GetAllDeliveryInfo getAllDeliveryInfo;
  final GetDefaultDeliveryInfo getDefaultDeliveryInfo;
  final SetDefaultDeliveryInfo setDefaultDeliveryInfo;

  DeliveryInfoBloc({
    required this.addDeliveryInfo,
    required this.updateDeliveryInfo,
    required this.deleteDeliveryInfo,
    required this.getAllDeliveryInfo,
    required this.getDefaultDeliveryInfo,
    required this.setDefaultDeliveryInfo,
  }) : super(DeliveryInfoInitial()) {
    on<LoadDeliveryInfosEvent>(_onLoadDeliveryInfos);
    on<AddDeliveryInfoEvent>(_onAddDeliveryInfo);
    on<UpdateDeliveryInfoEvent>(_onUpdateDeliveryInfo);
    on<DeleteDeliveryInfoEvent>(_onDeleteDeliveryInfo);
    on<SetDefaultDeliveryInfoEvent>(_onSetDefaultDeliveryInfo);
  }

  Future<void> _onLoadDeliveryInfos(
    LoadDeliveryInfosEvent event,
    Emitter<DeliveryInfoState> emit,
  ) async {
    emit(DeliveryInfoLoading());
    try {
      final infos = await getAllDeliveryInfo(event.userId);
      final defaultInfo = await getDefaultDeliveryInfo(event.userId);
      emit(DeliveryInfoLoaded(infos, defaultInfo));
    } catch (e) {
      emit(DeliveryInfoError(e.toString()));
    }
  }

  Future<void> _onAddDeliveryInfo(
    AddDeliveryInfoEvent event,
    Emitter<DeliveryInfoState> emit,
  ) async {
    try {
      await addDeliveryInfo(event.info);
      add(LoadDeliveryInfosEvent(event.info.userId));
    } catch (e) {
      emit(DeliveryInfoError(e.toString()));
    }
  }

  Future<void> _onUpdateDeliveryInfo(
    UpdateDeliveryInfoEvent event,
    Emitter<DeliveryInfoState> emit,
  ) async {
    try {
      await updateDeliveryInfo(event.info);
      add(LoadDeliveryInfosEvent(event.info.userId));
    } catch (e) {
      emit(DeliveryInfoError(e.toString()));
    }
  }

  Future<void> _onDeleteDeliveryInfo(
    DeleteDeliveryInfoEvent event,
    Emitter<DeliveryInfoState> emit,
  ) async {
    try {
      await deleteDeliveryInfo(event.id);
      // Reload assuming userId can be derived from cached delivery info
      final currentState = state;
      if (currentState is DeliveryInfoLoaded) {
        add(LoadDeliveryInfosEvent(currentState.defaultInfo?.userId ?? ""));
      }
    } catch (e) {
      emit(DeliveryInfoError(e.toString()));
    }
  }

  Future<void> _onSetDefaultDeliveryInfo(
    SetDefaultDeliveryInfoEvent event,
    Emitter<DeliveryInfoState> emit,
  ) async {
    try {
      await setDefaultDeliveryInfo(event.id);
      add(LoadDeliveryInfosEvent(event.userId));
    } catch (e) {
      emit(DeliveryInfoError(e.toString()));
    }
  }
}

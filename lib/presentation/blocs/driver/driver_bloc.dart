import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_delivery_app/domain/entities/driver/driver.dart';
import 'package:flutter_delivery_app/domain/repositories/driver/driver_repository.dart';
import 'package:injectable/injectable.dart';

part 'driver_event.dart';
part 'driver_state.dart';

@injectable
class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final DriverRepository repository;

  DriverBloc(this.repository) : super(DriverInitial()) {
    on<GetDriversByServiceIdEvent>(_onGetDriversByServiceId);
    on<GetDriverByIdEvent>(_onGetDriverById);
  }

  Future<void> _onGetDriversByServiceId(
    GetDriversByServiceIdEvent event,
    Emitter<DriverState> emit,
  ) async {
    emit(DriverLoading());
    try {
      final drivers = await repository.getDriversByServiceId(event.serviceId);
      emit(DriversLoaded(drivers));
    } catch (e) {
      emit(DriverError('Failed to load drivers'));
    }
  }

  Future<void> _onGetDriverById(
    GetDriverByIdEvent event,
    Emitter<DriverState> emit,
  ) async {
    emit(DriverLoading());
    try {
      final driver = await repository.getDriverById(event.driverId);
      if (driver != null) {
        emit(DriverLoaded(driver));
      } else {
        emit(DriverError('Driver not found'));
      }
    } catch (e) {
      emit(DriverError('Failed to load driver'));
    }
  }
}

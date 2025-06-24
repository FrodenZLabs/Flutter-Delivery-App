import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_all_services.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_by_id.dart';
import 'package:flutter_delivery_app/domain/usecases/service/search_services.dart';
import 'package:injectable/injectable.dart';

part 'service_event.dart';
part 'service_state.dart';

@injectable
class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final GetAllServices getAllServices;
  final GetServiceById getServiceById;
  final SearchServices searchServices;

  ServiceBloc({
    required this.getAllServices,
    required this.getServiceById,
    required this.searchServices,
  }) : super(ServiceInitial()) {
    on<LoadAllServices>(_onLoadAllServices);
    on<LoadGetServiceById>(_onGetServiceById);
    on<LoadSearchServices>(_onSearchServices);
  }

  Future<void> _onLoadAllServices(
    LoadAllServices event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final services = await getAllServices();
      emit(ServiceLoaded(services));
    } catch (e) {
      emit(ServiceError('Failed to load services'));
    }
  }

  Future<void> _onGetServiceById(
    LoadGetServiceById event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final service = await getServiceById(event.id);
      if (service != null) {
        emit(ServiceDetailLoaded(service));
      } else {
        emit(ServiceError('Service not found'));
      }
    } catch (e) {
      emit(ServiceError('Failed to load service'));
    }
  }

  Future<void> _onSearchServices(
    LoadSearchServices event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final services = await searchServices(event.query);
      emit(ServiceLoaded(services));
    } catch (e) {
      emit(ServiceError('Search failed'));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/service/pagination_meta_data.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_local_service_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_use_case.dart';
import 'package:injectable/injectable.dart';

part 'service_event.dart';
part 'service_state.dart';

@injectable
class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final GetServiceUseCase _getServiceUseCase;
  final GetLocalServiceUseCase _getLocalServiceUseCase;

  ServiceBloc(this._getServiceUseCase, this._getLocalServiceUseCase)
    : super(
        ServiceInitial(
          services: const [],
          params: const FilterServiceParams(),
          metaData: PaginationMetaData(limit: 0, pageSize: 20, total: 0),
        ),
      ) {
    on<LoadAllServices>(_onLoadAllServices);
    on<LoadMoreServices>(_onLoadMoreServices);
  }

  void _onLoadAllServices(
    LoadAllServices event,
    Emitter<ServiceState> emit,
  ) async {
    try {
      emit(
        ServiceLoading(
          services: const [],
          params: event.params,
          metaData: state.metaData,
        ),
      );

      // ✅ Step 1: Check local cache
      final cachedResult = await _getLocalServiceUseCase(NoParams());

      cachedResult.fold(
        (failure) {
          // Proceed to remote even if cache fails, but optionally log the failure
        },
        (cachedServiceResponse) {
          emit(
            ServiceLoaded(
              services: cachedServiceResponse.service,
              params: event.params,
              metaData: cachedServiceResponse.paginationMetaData,
            ),
          );
        },
      );

      // ✅ Step 2: Fetch from remote (to update data or if cache was empty)
      final result = await _getServiceUseCase(event.params);

      result.fold(
        (failure) {
          emit(
            ServiceError(
              services: state.services,
              params: event.params,
              failure: failure,
              metaData: state.metaData,
            ),
          );
        },
        (serviceResponse) {
          emit(
            ServiceLoaded(
              services: serviceResponse.service,
              params: event.params,
              metaData: serviceResponse.paginationMetaData,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        ServiceError(
          services: state.services,
          params: state.params,
          failure: ExceptionFailure(),
          metaData: state.metaData,
        ),
      );
    }
  }

  void _onLoadMoreServices(
    LoadMoreServices event,
    Emitter<ServiceState> emit,
  ) async {
    var state = this.state;
    var limit = state.metaData.limit;
    var total = state.metaData.total;
    var loadedServicesLength = state.services.length;

    if (state is ServiceLoaded && (loadedServicesLength < total)) {
      try {
        emit(
          ServiceLoading(
            services: state.services,
            params: state.params,
            metaData: state.metaData,
          ),
        );
        final result = await _getServiceUseCase(
          FilterServiceParams(limit: limit + 10),
        );
        result.fold(
          (failure) => emit(
            ServiceError(
              services: state.services,
              metaData: state.metaData,
              params: state.params,
              failure: failure,
            ),
          ),
          (serviceResponse) {
            List<Service> services = state.services;
            services.addAll(serviceResponse.service);
            emit(
              ServiceLoaded(
                services: services,
                metaData: state.metaData,
                params: state.params,
              ),
            );
          },
        );
      } catch (e) {
        emit(
          ServiceError(
            services: state.services,
            metaData: state.metaData,
            params: state.params,
            failure: ExceptionFailure(),
          ),
        );
      }
    }
  }
}

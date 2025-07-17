import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/service/pagination_meta_data.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_local_service_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_use_case.dart';
import 'package:injectable/injectable.dart';

part 'popular_service_event.dart';
part 'popular_service_state.dart';

@injectable
class PopularServicesBloc
    extends Bloc<PopularServicesEvent, PopularServicesState> {
  final GetServiceUseCase _getServiceUseCase;
  final GetLocalServiceUseCase _getLocalServiceUseCase;

  PopularServicesBloc(this._getServiceUseCase, this._getLocalServiceUseCase)
    : super(const PopularServicesInitial()) {
    on<LoadPopularServices>(_onLoadPopularServices);
  }

  void _onLoadPopularServices(
    LoadPopularServices event,
    Emitter<PopularServicesState> emit,
  ) async {
    emit(const PopularServicesLoading());

    try {
      // ✅ Step 1: Load from local cache first
      final cachedResult = await _getLocalServiceUseCase(NoParams());

      cachedResult.fold((failure) {}, (cachedServiceResponse) {
        emit(
          PopularServicesLoaded(
            services: cachedServiceResponse.service.take(6).toList(),
            metaData: cachedServiceResponse.paginationMetaData,
          ),
        );
      });

      // ✅ Step 2: Fetch updated data from remote
      final result = await _getServiceUseCase(
        const FilterServiceParams(limit: 6),
      );

      result.fold(
        (failure) {
          emit(PopularServicesError(failure: failure));
        },
        (response) {
          emit(
            PopularServicesLoaded(
              services: response.service,
              metaData: response.paginationMetaData,
            ),
          );
        },
      );
    } catch (e) {
      emit(PopularServicesError(failure: ExceptionFailure()));
    }
  }
}

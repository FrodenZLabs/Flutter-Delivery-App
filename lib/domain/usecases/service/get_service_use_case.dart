import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/service/service_response.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetServiceUseCase
    implements UseCase<ServiceResponse, FilterServiceParams> {
  final ServiceRepository repository;

  GetServiceUseCase(this.repository);

  @override
  Future<Either<Failure, ServiceResponse>> call(
    FilterServiceParams params,
  ) async {
    return await repository.getRemoteServices(params);
  }
}

class FilterServiceParams {
  final String? keyword; // Search keyword for service name
  final ServiceSortOrder sort; // Sorting option
  final int limit; // Items per page
  final int page; // Current page number

  const FilterServiceParams({
    this.keyword,
    this.sort = ServiceSortOrder.all,
    this.limit = 10,
    this.page = 1,
  });

  // Convert to query parameters for API calls
  Map<String, String> toQueryParams() {
    final Map<String, String> params = {
      'limit': limit.toString(),
      'page': page.toString(),
    };

    if (keyword != null && keyword!.isNotEmpty) {
      params['search'] = keyword!;
    }

    if (sort != ServiceSortOrder.all) {
      params['sort'] = sort.toQueryValue();
    }

    return params;
  }

  FilterServiceParams copyWith({
    String? keyword,
    ServiceSortOrder? sort,
    int? limit,
    int? page,
  }) {
    return FilterServiceParams(
      keyword: keyword ?? this.keyword,
      sort: sort ?? this.sort,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }
}

// ✅ Enum for sort order
enum ServiceSortOrder { priceHigh, priceLow, aToZ, zToA, all }

extension ServiceSortOrderExtension on ServiceSortOrder {
  String toQueryValue() {
    switch (this) {
      case ServiceSortOrder.priceHigh:
        return 'price_high';
      case ServiceSortOrder.priceLow:
        return 'price_low';
      case ServiceSortOrder.aToZ:
        return 'a_z';
      case ServiceSortOrder.zToA:
        return 'z_a';
      case ServiceSortOrder.all:
        return 'all';
    }
  }
}

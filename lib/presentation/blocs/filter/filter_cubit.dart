import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class FilterServiceCubit extends Cubit<FilterServiceParams> {
  final TextEditingController searchController = TextEditingController();

  FilterServiceCubit() : super(const FilterServiceParams());

  ServiceSortOrder? mapStringToSortOrder(String? sortString) {
    switch (sortString) {
      case 'price_high':
        return ServiceSortOrder.priceHigh;
      case 'price_low':
        return ServiceSortOrder.priceLow;
      case 'a_z':
        return ServiceSortOrder.aToZ;
      case 'z_a':
        return ServiceSortOrder.zToA;
      default:
        return ServiceSortOrder.all;
    }
  }

  void update({String? keyword, String? sort}) {
    emit(
      state.copyWith(
        keyword: keyword ?? state.keyword,
        sort: sort != null ? mapStringToSortOrder(sort) : state.sort,
      ),
    );
  }

  /// ✅ Clear filters back to default
  void reset() {
    searchController.clear();
    emit(const FilterServiceParams());
  }

  /// ✅ Useful for showing filter chips count (active filters)
  int getFiltersCount() {
    int count = 0;

    // ✅ Check if keyword exists
    if (state.keyword != null && state.keyword!.isNotEmpty) {
      count++;
    }

    // ✅ Check if sort is not 'all'
    if (state.sort != ServiceSortOrder.all) {
      count++;
    }

    return count;
  }
}

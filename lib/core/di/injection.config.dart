// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_delivery_app/core/di/di_module.dart' as _i151;
import 'package:flutter_delivery_app/data/data_sources/local/service_local_data_source.dart'
    as _i1064;
import 'package:flutter_delivery_app/data/data_sources/remote/service_remote_data_source.dart'
    as _i1047;
import 'package:flutter_delivery_app/data/models/service/service_model.dart'
    as _i506;
import 'package:flutter_delivery_app/data/repositories_impl/service_repository_impl.dart'
    as _i762;
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart'
    as _i591;
import 'package:flutter_delivery_app/domain/usecases/service/get_all_services.dart'
    as _i8;
import 'package:flutter_delivery_app/domain/usecases/service/get_service_by_id.dart'
    as _i276;
import 'package:flutter_delivery_app/domain/usecases/service/search_services.dart'
    as _i85;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dIModule = _$DIModule();
    await gh.factoryAsync<_i979.Box<_i506.ServiceModel>>(
      () => dIModule.serviceBox,
      preResolve: true,
    );
    gh.lazySingleton<_i519.Client>(() => dIModule.httpClient);
    gh.lazySingleton<_i1064.ServiceLocalDataSource>(() =>
        _i1064.HiveServiceLocalDataSource(gh<_i979.Box<_i506.ServiceModel>>()));
    gh.lazySingleton<_i1047.ServiceRemoteDataSource>(
        () => _i1047.HttpServiceRemoteDataSource(gh<_i519.Client>()));
    gh.lazySingleton<_i591.ServiceRepository>(() => _i762.ServiceRepositoryImpl(
          remoteDataSource: gh<_i1047.ServiceRemoteDataSource>(),
          localDataSource: gh<_i1064.ServiceLocalDataSource>(),
        ));
    gh.lazySingleton<_i8.GetAllServices>(
        () => _i8.GetAllServices(gh<_i591.ServiceRepository>()));
    gh.lazySingleton<_i276.GetServiceById>(
        () => _i276.GetServiceById(gh<_i591.ServiceRepository>()));
    gh.lazySingleton<_i85.SearchServices>(
        () => _i85.SearchServices(gh<_i591.ServiceRepository>()));
    return this;
  }
}

class _$DIModule extends _i151.DIModule {}

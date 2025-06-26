// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_delivery_app/core/di/di_module.dart' as _i151;
import 'package:flutter_delivery_app/data/data_sources/local/delivery_info_local_data_source.dart'
    as _i191;
import 'package:flutter_delivery_app/data/data_sources/local/schedule_local_data_source.dart'
    as _i367;
import 'package:flutter_delivery_app/data/data_sources/local/service_local_data_source.dart'
    as _i1064;
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart'
    as _i943;
import 'package:flutter_delivery_app/data/data_sources/remote/delivery_info_remote_data_source.dart'
    as _i596;
import 'package:flutter_delivery_app/data/data_sources/remote/driver_remote_data_source.dart'
    as _i147;
import 'package:flutter_delivery_app/data/data_sources/remote/rating_remote_data_source.dart'
    as _i407;
import 'package:flutter_delivery_app/data/data_sources/remote/schedule_remote_data_source.dart'
    as _i1035;
import 'package:flutter_delivery_app/data/data_sources/remote/service_remote_data_source.dart'
    as _i1047;
import 'package:flutter_delivery_app/data/data_sources/remote/user_remote_data_source.dart'
    as _i1038;
import 'package:flutter_delivery_app/data/models/service/service_model.dart'
    as _i506;
import 'package:flutter_delivery_app/data/models/user/user_model.dart' as _i866;
import 'package:flutter_delivery_app/data/repositories_impl/delivery_info_repository_impl.dart'
    as _i74;
import 'package:flutter_delivery_app/data/repositories_impl/driver_repository_impl.dart'
    as _i256;
import 'package:flutter_delivery_app/data/repositories_impl/rating_repository_impl.dart'
    as _i653;
import 'package:flutter_delivery_app/data/repositories_impl/schedule_repository_impl.dart'
    as _i498;
import 'package:flutter_delivery_app/data/repositories_impl/service_repository_impl.dart'
    as _i762;
import 'package:flutter_delivery_app/data/repositories_impl/user_repository_impl.dart'
    as _i1026;
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart'
    as _i993;
import 'package:flutter_delivery_app/domain/repositories/driver/driver_repository.dart'
    as _i16;
import 'package:flutter_delivery_app/domain/repositories/rating/rating_repository.dart'
    as _i56;
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart'
    as _i24;
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart'
    as _i591;
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart'
    as _i14;
import 'package:flutter_delivery_app/domain/usecases/delivery/add_delivery_info.dart'
    as _i281;
import 'package:flutter_delivery_app/domain/usecases/delivery/delete_delivery_info.dart'
    as _i233;
import 'package:flutter_delivery_app/domain/usecases/delivery/get_all_delivery_info.dart'
    as _i515;
import 'package:flutter_delivery_app/domain/usecases/delivery/get_default_delivery_info.dart'
    as _i525;
import 'package:flutter_delivery_app/domain/usecases/delivery/set_default_delivery_info.dart'
    as _i289;
import 'package:flutter_delivery_app/domain/usecases/delivery/update_delivery_info.dart'
    as _i537;
import 'package:flutter_delivery_app/domain/usecases/driver/get_driver_by_id.dart'
    as _i436;
import 'package:flutter_delivery_app/domain/usecases/driver/get_drivers_by_service_id.dart'
    as _i714;
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating.dart'
    as _i345;
import 'package:flutter_delivery_app/domain/usecases/rating/get_rating_by_user_id.dart'
    as _i207;
import 'package:flutter_delivery_app/domain/usecases/schedule/book_schedule.dart'
    as _i175;
import 'package:flutter_delivery_app/domain/usecases/schedule/cancel_schedule.dart'
    as _i263;
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedule_by_id.dart'
    as _i859;
import 'package:flutter_delivery_app/domain/usecases/schedule/get_schedules_by_user.dart'
    as _i875;
import 'package:flutter_delivery_app/domain/usecases/schedule/update_schedule.dart'
    as _i108;
import 'package:flutter_delivery_app/domain/usecases/service/get_all_services.dart'
    as _i8;
import 'package:flutter_delivery_app/domain/usecases/service/get_service_by_id.dart'
    as _i276;
import 'package:flutter_delivery_app/domain/usecases/service/search_services.dart'
    as _i85;
import 'package:flutter_delivery_app/domain/usecases/user/get_user.dart'
    as _i925;
import 'package:flutter_delivery_app/domain/usecases/user/login_user.dart'
    as _i457;
import 'package:flutter_delivery_app/domain/usecases/user/register_user.dart'
    as _i79;
import 'package:flutter_delivery_app/domain/usecases/user/update_user.dart'
    as _i804;
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_bloc.dart'
    as _i606;
import 'package:flutter_delivery_app/presentation/blocs/driver/driver_bloc.dart'
    as _i289;
import 'package:flutter_delivery_app/presentation/blocs/home/navbar_cubit.dart'
    as _i860;
import 'package:flutter_delivery_app/presentation/blocs/rating/rating_bloc.dart'
    as _i244;
import 'package:flutter_delivery_app/presentation/blocs/schedule/schedule_bloc.dart'
    as _i500;
import 'package:flutter_delivery_app/presentation/blocs/service/service_bloc.dart'
    as _i367;
import 'package:flutter_delivery_app/presentation/blocs/user/user_bloc.dart'
    as _i182;
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
    gh.factory<_i860.NavbarCubit>(() => _i860.NavbarCubit());
    gh.lazySingleton<_i519.Client>(() => dIModule.httpClient);
    gh.lazySingleton<_i191.DeliveryInfoLocalDataSource>(
        () => _i191.HiveDeliveryInfoLocalDataSource());
    gh.lazySingleton<_i1064.ServiceLocalDataSource>(() =>
        _i1064.HiveServiceLocalDataSource(gh<_i979.Box<_i506.ServiceModel>>()));
    gh.lazySingleton<_i367.ScheduleLocalDataSource>(
        () => _i367.HiveScheduleLocalDataSource());
    gh.lazySingleton<_i943.UserLocalDataSource>(() =>
        _i943.HiveUserLocalDataSource(
            testBox: gh<_i979.Box<_i866.UserModel>>()));
    gh.lazySingleton<_i596.DeliveryInfoRemoteDataSource>(
        () => _i596.HttpDeliveryInfoRemoteDataSource(
              gh<_i519.Client>(),
              gh<_i191.DeliveryInfoLocalDataSource>(),
            ));
    gh.lazySingleton<_i1038.UserRemoteDataSource>(
        () => _i1038.HttpUserRemoteDataSource(gh<_i519.Client>()));
    gh.lazySingleton<_i407.RatingRemoteDataSource>(
        () => _i407.HttpRatingRemoteDataSource(gh<_i519.Client>()));
    gh.lazySingleton<_i147.DriverRemoteDataSource>(
        () => _i147.HttpDriverRemoteDataSource(gh<_i519.Client>()));
    gh.lazySingleton<_i1035.ScheduleRemoteDataSource>(
        () => _i1035.HttpScheduleRemoteDataSource(
              gh<_i519.Client>(),
              gh<_i367.ScheduleLocalDataSource>(),
            ));
    gh.lazySingleton<_i1047.ServiceRemoteDataSource>(
        () => _i1047.HttpServiceRemoteDataSource(gh<_i519.Client>()));
    gh.lazySingleton<_i24.ScheduleRepository>(
        () => _i498.ScheduleRepositoryImpl(
              gh<_i1035.ScheduleRemoteDataSource>(),
              gh<_i367.ScheduleLocalDataSource>(),
            ));
    gh.lazySingleton<_i175.BookSchedule>(
        () => _i175.BookSchedule(gh<_i24.ScheduleRepository>()));
    gh.lazySingleton<_i263.CancelSchedule>(
        () => _i263.CancelSchedule(gh<_i24.ScheduleRepository>()));
    gh.lazySingleton<_i875.GetSchedulesByUser>(
        () => _i875.GetSchedulesByUser(gh<_i24.ScheduleRepository>()));
    gh.lazySingleton<_i859.GetScheduleById>(
        () => _i859.GetScheduleById(gh<_i24.ScheduleRepository>()));
    gh.lazySingleton<_i108.UpdateSchedule>(
        () => _i108.UpdateSchedule(gh<_i24.ScheduleRepository>()));
    gh.lazySingleton<_i14.UserRepository>(() => _i1026.UserRepositoryImpl(
          gh<_i1038.UserRemoteDataSource>(),
          gh<_i943.UserLocalDataSource>(),
        ));
    gh.factory<_i500.ScheduleBloc>(() => _i500.ScheduleBloc(
          bookSchedule: gh<_i175.BookSchedule>(),
          updateSchedule: gh<_i108.UpdateSchedule>(),
          cancelSchedule: gh<_i263.CancelSchedule>(),
          getScheduleById: gh<_i859.GetScheduleById>(),
          getSchedulesByUser: gh<_i875.GetSchedulesByUser>(),
        ));
    gh.lazySingleton<_i16.DriverRepository>(
        () => _i256.DriverRepositoryImpl(gh<_i147.DriverRemoteDataSource>()));
    gh.lazySingleton<_i993.DeliveryInfoRepository>(
        () => _i74.DeliveryInfoRepositoryImpl(
              gh<_i596.DeliveryInfoRemoteDataSource>(),
              gh<_i191.DeliveryInfoLocalDataSource>(),
            ));
    gh.lazySingleton<_i56.RatingRepository>(
        () => _i653.RatingRepositoryImpl(gh<_i407.RatingRemoteDataSource>()));
    gh.lazySingleton<_i591.ServiceRepository>(() => _i762.ServiceRepositoryImpl(
          remoteDataSource: gh<_i1047.ServiceRemoteDataSource>(),
          localDataSource: gh<_i1064.ServiceLocalDataSource>(),
        ));
    gh.lazySingleton<_i714.GetDriversByServiceId>(
        () => _i714.GetDriversByServiceId(gh<_i16.DriverRepository>()));
    gh.lazySingleton<_i436.GetDriverById>(
        () => _i436.GetDriverById(gh<_i16.DriverRepository>()));
    gh.factory<_i289.DriverBloc>(
        () => _i289.DriverBloc(gh<_i16.DriverRepository>()));
    gh.lazySingleton<_i281.AddDeliveryInfo>(
        () => _i281.AddDeliveryInfo(gh<_i993.DeliveryInfoRepository>()));
    gh.lazySingleton<_i233.DeleteDeliveryInfo>(
        () => _i233.DeleteDeliveryInfo(gh<_i993.DeliveryInfoRepository>()));
    gh.lazySingleton<_i515.GetAllDeliveryInfo>(
        () => _i515.GetAllDeliveryInfo(gh<_i993.DeliveryInfoRepository>()));
    gh.lazySingleton<_i525.GetDefaultDeliveryInfo>(
        () => _i525.GetDefaultDeliveryInfo(gh<_i993.DeliveryInfoRepository>()));
    gh.lazySingleton<_i289.SetDefaultDeliveryInfo>(
        () => _i289.SetDefaultDeliveryInfo(gh<_i993.DeliveryInfoRepository>()));
    gh.lazySingleton<_i537.UpdateDeliveryInfo>(
        () => _i537.UpdateDeliveryInfo(gh<_i993.DeliveryInfoRepository>()));
    gh.lazySingleton<_i925.GetUser>(
        () => _i925.GetUser(gh<_i14.UserRepository>()));
    gh.lazySingleton<_i457.LoginUser>(
        () => _i457.LoginUser(gh<_i14.UserRepository>()));
    gh.lazySingleton<_i79.RegisterUser>(
        () => _i79.RegisterUser(gh<_i14.UserRepository>()));
    gh.lazySingleton<_i804.UpdateUser>(
        () => _i804.UpdateUser(gh<_i14.UserRepository>()));
    gh.lazySingleton<_i345.AddRating>(
        () => _i345.AddRating(gh<_i56.RatingRepository>()));
    gh.lazySingleton<_i207.GetRatingsByUser>(
        () => _i207.GetRatingsByUser(gh<_i56.RatingRepository>()));
    gh.factory<_i182.UserBloc>(() => _i182.UserBloc(
          registerUser: gh<_i79.RegisterUser>(),
          loginUser: gh<_i457.LoginUser>(),
          getUser: gh<_i925.GetUser>(),
          updateUser: gh<_i804.UpdateUser>(),
        ));
    gh.lazySingleton<_i8.GetAllServices>(
        () => _i8.GetAllServices(gh<_i591.ServiceRepository>()));
    gh.lazySingleton<_i276.GetServiceById>(
        () => _i276.GetServiceById(gh<_i591.ServiceRepository>()));
    gh.lazySingleton<_i85.SearchServices>(
        () => _i85.SearchServices(gh<_i591.ServiceRepository>()));
    gh.factory<_i244.RatingBloc>(() => _i244.RatingBloc(
          addRating: gh<_i345.AddRating>(),
          getRatingsByUser: gh<_i207.GetRatingsByUser>(),
        ));
    gh.factory<_i606.DeliveryInfoBloc>(() => _i606.DeliveryInfoBloc(
          addDeliveryInfo: gh<_i281.AddDeliveryInfo>(),
          updateDeliveryInfo: gh<_i537.UpdateDeliveryInfo>(),
          deleteDeliveryInfo: gh<_i233.DeleteDeliveryInfo>(),
          getAllDeliveryInfo: gh<_i515.GetAllDeliveryInfo>(),
          getDefaultDeliveryInfo: gh<_i525.GetDefaultDeliveryInfo>(),
          setDefaultDeliveryInfo: gh<_i289.SetDefaultDeliveryInfo>(),
        ));
    gh.factory<_i367.ServiceBloc>(() => _i367.ServiceBloc(
          getAllServices: gh<_i8.GetAllServices>(),
          getServiceById: gh<_i276.GetServiceById>(),
          searchServices: gh<_i85.SearchServices>(),
        ));
    return this;
  }
}

class _$DIModule extends _i151.DIModule {}

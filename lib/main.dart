import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/strings.dart';
import 'package:flutter_delivery_app/core/di/injection.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/filter/filter_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/home/navbar_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/popular_service/popular_service_bloc.dart';
import 'package:flutter_delivery_app/presentation/blocs/rating/rating_bloc.dart';
import 'package:flutter_delivery_app/presentation/blocs/schedule/schedule_bloc.dart';
import 'package:flutter_delivery_app/presentation/blocs/service/service_bloc.dart';
import 'package:flutter_delivery_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_delivery_app/presentation/widgets/loading_overlay.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 3));

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapter
  Hive.registerAdapter(ServiceModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(DeliveryInfoModelAdapter());
  Hive.registerAdapter(ScheduleModelAdapter());

  // Initialize Dependency Injection
  await configureDependencies();

  // Launch the app
  runApp(const DeliveryApp());
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<NavbarCubit>()),
        BlocProvider(create: (context) => getIt<FilterServiceCubit>()),
        BlocProvider(create: (context) => getIt<ServiceBloc>()),
        BlocProvider(create: (context) => getIt<PopularServicesBloc>()),
        BlocProvider(create: (context) => getIt<DeliveryInfoActionCubit>()),
        BlocProvider(create: (context) => getIt<DeliveryInfoFetchCubit>()),
        BlocProvider(create: (context) => getIt<UserBloc>()),
        BlocProvider(create: (context) => getIt<RatingBloc>()),
        BlocProvider(create: (context) => getIt<ScheduleBloc>()),
      ],
      child: ToastificationWrapper(
        child: ResponsiveSizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              navigatorKey: LoadingOverlay.navigatorKey,
              title: appTitle,
              debugShowCheckedModeBanner: false,
              initialRoute: AppRouter.home,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}

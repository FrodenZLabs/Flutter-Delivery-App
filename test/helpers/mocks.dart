import 'package:flutter_delivery_app/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/local/schedule_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/local/service_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/driver_remote_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/rating_remote_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/schedule_remote_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/service_remote_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:flutter_delivery_app/domain/repositories/driver/driver_repository.dart';
import 'package:flutter_delivery_app/domain/repositories/rating/rating_repository.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ServiceRepository,
  ServiceLocalDataSource,
  ServiceRemoteDataSource,
  UserRepository,
  Box,
  UserRemoteDataSource,
  UserLocalDataSource,
  DeliveryInfoRepository,
  DeliveryInfoLocalDataSource,
  DeliveryInfoRemoteDataSource,
  ScheduleRepository,
  ScheduleLocalDataSource,
  ScheduleRemoteDataSource,
  DriverRepository,
  DriverRemoteDataSource,
  RatingRepository,
  RatingRemoteDataSource,
  http.Client,
])
void main() {}

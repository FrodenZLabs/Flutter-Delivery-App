import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class DIModule {
  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker.createInstance();

  @preResolve
  Future<Box<ServiceModel>> get serviceBox async {
    return await Hive.openBox<ServiceModel>('services');
  }
}

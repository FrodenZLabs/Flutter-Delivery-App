import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@module
abstract class DIModule {
  @lazySingleton
  http.Client get httpClient => http.Client();

  @preResolve
  Future<Box<ServiceModel>> get serviceBox async {
    return await Hive.openBox<ServiceModel>('services');
  }
}

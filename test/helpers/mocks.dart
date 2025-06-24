import 'package:flutter_delivery_app/data/data_sources/local/service_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/service_remote_data_source.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ServiceRepository,
  ServiceLocalDataSource,
  ServiceRemoteDataSource,
  http.Client,
])
void main() {}

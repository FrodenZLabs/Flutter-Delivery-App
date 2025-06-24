import 'dart:convert';

import 'package:flutter_delivery_app/data/models/driver/driver_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class DriverRemoteDataSource {
  Future<List<DriverModel>> getDriversByServiceId(String serviceId);
  Future<DriverModel?> getDriverById(String driverId);
}

@LazySingleton(as: DriverRemoteDataSource)
class HttpDriverRemoteDataSource implements DriverRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'http://localhost:5000/api/drivers';

  HttpDriverRemoteDataSource(this.client);

  @override
  Future<List<DriverModel>> getDriversByServiceId(String serviceId) async {
    final response = await client.get(Uri.parse('$baseUrl/service/$serviceId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DriverModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load drivers');
    }
  }

  @override
  Future<DriverModel?> getDriverById(String driverId) async {
    final response = await client.get(Uri.parse('$baseUrl/$driverId'));

    if (response.statusCode == 200) {
      return DriverModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}

import 'dart:convert';

import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> fetchRemoteServices();
  Future<ServiceModel?> fetchServiceById(String id);
  Future<List<ServiceModel>> searchServices(String keyword);
}

@LazySingleton(as: ServiceRemoteDataSource)
class HttpServiceRemoteDataSource implements ServiceRemoteDataSource {
  final http.Client client;

  HttpServiceRemoteDataSource(this.client);

  final String baseUrl = 'https://example.com/api/services';

  @override
  Future<List<ServiceModel>> fetchRemoteServices() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => ServiceModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch services');
    }
  }

  @override
  Future<ServiceModel?> fetchServiceById(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ServiceModel.fromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<List<ServiceModel>> searchServices(String keyword) async {
    final response = await client.get(Uri.parse('$baseUrl/search?q=$keyword'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => ServiceModel.fromJson(e)).toList();
    } else {
      throw Exception('Search failed');
    }
  }
}

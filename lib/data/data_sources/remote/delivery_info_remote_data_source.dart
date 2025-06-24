import 'dart:convert';

import 'package:flutter_delivery_app/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class DeliveryInfoRemoteDataSource {
  Future<void> addDeliveryInfo(DeliveryInfoModel info);
  Future<void> updateDeliveryInfo(DeliveryInfoModel info);
  Future<void> deleteDeliveryInfo(String id);
  Future<List<DeliveryInfoModel>> fetchAllDeliveryInfo(String userId);
}

@LazySingleton(as: DeliveryInfoRemoteDataSource)
class HttpDeliveryInfoRemoteDataSource implements DeliveryInfoRemoteDataSource {
  final http.Client client;
  final DeliveryInfoLocalDataSource? localDataSource;

  HttpDeliveryInfoRemoteDataSource(this.client, this.localDataSource);

  final String baseUrl = 'http://localhost:5000/api/delivery';

  @override
  Future<void> addDeliveryInfo(DeliveryInfoModel info) async {
    final response = await client.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(info.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final addedInfo = DeliveryInfoModel.fromJson(data);
      await localDataSource?.cacheDeliveryInfo(addedInfo);
    }
  }

  @override
  Future<void> updateDeliveryInfo(DeliveryInfoModel info) async {
    final response = await client.put(
      Uri.parse('$baseUrl/update/${info.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(info.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final updatedInfo = DeliveryInfoModel.fromJson(data);
      await localDataSource?.updateDeliveryInfo(updatedInfo);
    }
  }

  @override
  Future<void> deleteDeliveryInfo(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode == 200) {
      await localDataSource?.deleteDeliveryInfo(id);
    }
  }

  @override
  Future<List<DeliveryInfoModel>> fetchAllDeliveryInfo(String userId) async {
    final response = await client.get(Uri.parse('$baseUrl/user/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final infos = data
          .map((json) => DeliveryInfoModel.fromJson(json))
          .toList()
          .cast<DeliveryInfoModel>();

      // Sync with local
      await localDataSource?.syncAllDeliveryInfo(infos);
      return infos;
    } else {
      throw Exception('Failed to fetch delivery info');
    }
  }
}

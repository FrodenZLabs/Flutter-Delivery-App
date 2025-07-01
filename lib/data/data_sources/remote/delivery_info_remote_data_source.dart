import 'package:flutter_delivery_app/core/constants/strings.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class DeliveryInfoRemoteDataSource {
  Future<List<DeliveryInfoModel>> getDeliveryInfo(String token);
  Future<DeliveryInfoModel> addDeliveryInfo(
    DeliveryInfoModel params,
    String token,
  );
  Future<DeliveryInfoModel> editDeliveryInfo(
    DeliveryInfoModel params,
    String token,
  );
}

@LazySingleton(as: DeliveryInfoRemoteDataSource)
class HttpDeliveryInfoRemoteDataSource implements DeliveryInfoRemoteDataSource {
  final http.Client client;
  HttpDeliveryInfoRemoteDataSource({required this.client});

  @override
  Future<DeliveryInfoModel> addDeliveryInfo(
    DeliveryInfoModel params,
    String token,
  ) async {
    final response = await client.post(
      Uri.parse('$baseUrl/delivery-info/user/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: deliveryInfoModelToJson(params),
    );

    if (response.statusCode == 200) {
      return deliveryInfoModelFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DeliveryInfoModel> editDeliveryInfo(
    DeliveryInfoModel params,
    String token,
  ) async {
    final response = await client.put(
      Uri.parse('$baseUrl/delivery-info/user/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: deliveryInfoModelToJson(params),
    );

    if (response.statusCode == 200) {
      return deliveryInfoModelFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DeliveryInfoModel>> getDeliveryInfo(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/delivery-info'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return deliveryInfoModelListFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }
}

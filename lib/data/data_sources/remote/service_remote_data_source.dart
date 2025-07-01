import 'package:flutter/cupertino.dart';
import 'package:flutter_delivery_app/core/constants/strings.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/data/models/service/service_response_model.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class ServiceRemoteDataSource {
  Future<ServiceResponseModel> getServices(FilterServiceParams params);
}

@LazySingleton(as: ServiceRemoteDataSource)
class HttpServiceRemoteDataSource implements ServiceRemoteDataSource {
  final http.Client client;

  HttpServiceRemoteDataSource(this.client);

  @override
  Future<ServiceResponseModel> getServices(FilterServiceParams params) async {
    final uri = Uri.parse('$baseUrl/services').replace(
      queryParameters: params
          .toQueryParams(), // ✅ Now uses the full pagination + filter map
    );

    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200) {
      return serviceResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_delivery_app/core/constants/strings.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/models/user/authentication_response_model.dart';
import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:flutter_delivery_app/domain/usecases/user/login_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/register_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> registerUser(RegisterParams params);
  Future<AuthenticationResponseModel> loginUser(LoginParams params);
}

@LazySingleton(as: UserRemoteDataSource)
class HttpUserRemoteDataSource implements UserRemoteDataSource {
  final http.Client client;
  final UserLocalDataSource localDataSource;

  HttpUserRemoteDataSource(this.client, this.localDataSource);

  @override
  Future<AuthenticationResponseModel> loginUser(LoginParams params) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': params.email, 'password': params.password}),
    );
    debugPrint("Response: ${response.statusCode}");
    debugPrint("Response: ${response.body}");

    if (response.statusCode == 200) {
      final authResponse = authenticationResponseModelFromJson(response.body);
      await localDataSource.saveToken(authResponse.token);
      await localDataSource.saveUser(authResponse.user);
      return authResponse;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> registerUser(RegisterParams params) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/sign-up'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'firstName': params.firstName,
        'lastName': params.lastName,
        'email': params.email,
        'password': params.password,
      }),
    );

    if (response.statusCode == 201) {
      return userModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }
}

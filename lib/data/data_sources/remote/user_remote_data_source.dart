import 'dart:convert';

import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> registerUser(UserModel user);
  Future<UserModel> loginUser(String email, String password);
  Future<UserModel> updateUser(UserModel user);
  Future<UserModel?> getUser(String id);
}

@LazySingleton(as: UserRemoteDataSource)
class HttpUserRemoteDataSource implements UserRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://example.com/api/users';

  HttpUserRemoteDataSource(this.client);

  @override
  Future<UserModel> registerUser(UserModel user) async {
    final response = await client.post(
      Uri.parse('$baseUrl/register'),
      body: json.encode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    final data = json.decode(response.body);
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> loginUser(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    final data = json.decode(response.body);
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel?> getUser(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    final response = await client.put(
      Uri.parse('$baseUrl/${user.id}'),
      body: json.encode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    final data = json.decode(response.body);
    return UserModel.fromJson(data);
  }
}

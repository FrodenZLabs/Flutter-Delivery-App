import 'dart:convert';

import 'package:flutter_delivery_app/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late HttpUserRemoteDataSource remoteDataSource;
  late MockClient mockClient;

  const baseUrl = 'https://example.com/api/users';

  final userJson = {
    'id': '1',
    'first_name': 'Steve',
    'last_name': 'Kibe',
    'email': 'kibe@example.com',
    'password': 'pass123',
    'image_url': null,
  };

  final userModel = UserModel.fromJson(userJson);

  setUp(() {
    mockClient = MockClient();
    remoteDataSource = HttpUserRemoteDataSource(mockClient);
  });

  test('registerUser returns UserModel from server', () async {
    when(
      mockClient.post(
        Uri.parse('$baseUrl/register'),
        headers: anyNamed('headers'),
        body: json.encode(userModel.toJson()),
      ),
    ).thenAnswer((_) async => http.Response(json.encode(userJson), 200));

    final result = await remoteDataSource.registerUser(userModel);

    expect(result, isA<UserModel>());
    expect(result.id, '1');
  });

  test('loginUser returns UserModel from server', () async {
    when(
      mockClient.post(
        Uri.parse('$baseUrl/login'),
        headers: anyNamed('headers'),
        body: json.encode({'email': 'kibe@example.com', 'password': 'pass123'}),
      ),
    ).thenAnswer((_) async => http.Response(json.encode(userJson), 200));

    final result = await remoteDataSource.loginUser(
      'kibe@example.com',
      'pass123',
    );

    expect(result.email, 'kibe@example.com');
  });

  test('getUser returns UserModel by ID', () async {
    when(
      mockClient.get(Uri.parse('$baseUrl/1')),
    ).thenAnswer((_) async => http.Response(json.encode(userJson), 200));

    final result = await remoteDataSource.getUser('1');

    expect(result?.id, '1');
  });

  test('updateUser returns updated UserModel', () async {
    when(
      mockClient.put(
        Uri.parse('$baseUrl/1'),
        headers: anyNamed('headers'),
        body: json.encode(userModel.toJson()),
      ),
    ).thenAnswer((_) async => http.Response(json.encode(userJson), 200));

    final result = await remoteDataSource.updateUser(userModel);

    expect(result.firstName, 'Steve');
  });
}

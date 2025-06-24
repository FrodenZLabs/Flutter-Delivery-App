import 'dart:convert';

import 'package:flutter_delivery_app/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late HttpDeliveryInfoRemoteDataSource remoteDataSource;
  late MockDeliveryInfoLocalDataSource mockLocalDataSource;
  late MockClient mockClient;

  final testModel = DeliveryInfoModel(
    id: '1',
    userId: 'user1',
    address: 'Test Street',
    city: 'Nairobi',
    contactNumber: '0700000000',
    isDefault: false,
  );

  setUp(() {
    mockClient = MockClient();
    mockLocalDataSource = MockDeliveryInfoLocalDataSource();
    remoteDataSource = HttpDeliveryInfoRemoteDataSource(
      mockClient,
      mockLocalDataSource,
    );
  });

  test('should add delivery info via POST', () async {
    when(
      mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode(testModel.toJson()), 200),
    );

    await remoteDataSource.addDeliveryInfo(testModel);

    verify(
      mockClient.post(
        Uri.parse('http://localhost:5000/api/delivery/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(testModel.toJson()),
      ),
    ).called(1);
  });

  test('should update delivery info via PUT', () async {
    when(
      mockClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode(testModel.toJson()), 200),
    );

    await remoteDataSource.updateDeliveryInfo(testModel);

    verify(
      mockClient.put(
        Uri.parse('http://localhost:5000/api/delivery/update/1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(testModel.toJson()),
      ),
    ).called(1);
  });

  test('should delete delivery info via DELETE', () async {
    when(
      mockClient.delete(any),
    ).thenAnswer((_) async => http.Response('{}', 200));

    await remoteDataSource.deleteDeliveryInfo(testModel.id);

    verify(
      mockClient.delete(
        Uri.parse('http://localhost:5000/api/delivery/delete/1'),
      ),
    ).called(1);
  });
}

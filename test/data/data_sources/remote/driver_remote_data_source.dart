import 'dart:convert';

import 'package:flutter_delivery_app/data/data_sources/remote/driver_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/driver/driver_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late HttpDriverRemoteDataSource remoteDataSource;
  late MockClient mockClient;

  final driverJson = {
    "id": "driver1",
    "serviceId": "service1",
    "firstName": "John",
    "lastName": "Doe",
    "contactNumber": "0712345678",
    "licensePlate": "KDA 123X",
    "vehicleType": "Van",
    "profilePictureUrl": "http://image.com/profile.jpg",
  };

  final driverModel = DriverModel.fromJson(driverJson);

  setUp(() {
    mockClient = MockClient();
    remoteDataSource = HttpDriverRemoteDataSource(mockClient);
  });

  group('getDriverById', () {
    test('should return DriverModel when status code is 200', () async {
      when(
        mockClient.get(Uri.parse('http://localhost:5000/api/drivers/driver1')),
      ).thenAnswer((_) async => http.Response(jsonEncode(driverJson), 200));

      final result = await remoteDataSource.getDriverById('driver1');

      expect(result, isA<DriverModel>());
      expect(result?.id, 'driver1');
    });
  });

  group('getDriversByServiceId', () {
    test('should return list of DriverModel when status code is 200', () async {
      when(
        mockClient.get(
          Uri.parse('http://localhost:5000/api/drivers/service/service1'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode([driverJson]), 200));

      final result = await remoteDataSource.getDriversByServiceId('service1');

      expect(result, isA<List<DriverModel>>());
      expect(result.first.id, 'driver1');
    });
  });
}

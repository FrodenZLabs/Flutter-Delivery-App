import 'dart:io';

import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  late Box<UserModel> box;
  late HiveUserLocalDataSource localDataSource;

  final userModel = UserModel(
    id: '1',
    firstName: 'Steve',
    lastName: 'Kibe',
    email: 'kibe@example.com',
    password: 'pass123',
    imageUrl: null,
  );

  setUpAll(() async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    Hive.registerAdapter(UserModelAdapter());
    box = await Hive.openBox<UserModel>('userBox');
    localDataSource = HiveUserLocalDataSource(); // uses the real Hive
  });

  tearDownAll(() async {
    await box.clear();
    await box.close();
  });

  test('should cache user locally', () async {
    await localDataSource.cacheUser(userModel);
    final stored = box.get('user');
    expect(stored, equals(userModel));
  });

  test('should return cached user', () async {
    await box.put('user', userModel);
    final result = await localDataSource.getCachedUser();
    expect(result, isA<UserModel>());
    expect(result?.email, 'kibe@example.com');
  });

  test('should clear cached user', () async {
    await box.put('user', userModel);
    await localDataSource.clearUser();
    expect(box.get('user'), isNull);
  });
}

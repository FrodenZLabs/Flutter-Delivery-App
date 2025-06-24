import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearUser();
}

@LazySingleton(as: UserLocalDataSource)
class HiveUserLocalDataSource implements UserLocalDataSource {
  static const boxName = 'userBox';
  final Box<UserModel>? testBox;

  HiveUserLocalDataSource({this.testBox}); // Add optional injected box

  Future<Box<UserModel>> _getBox() async {
    if (testBox != null) return testBox!;
    return await Hive.openBox<UserModel>(boxName);
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(boxName);
    await box.put('user', user);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final box = await Hive.openBox<UserModel>(boxName);
    return box.get('user');
  }

  @override
  Future<void> clearUser() async {
    final box = await Hive.openBox<UserModel>(boxName);
    await box.delete('user');
  }
}

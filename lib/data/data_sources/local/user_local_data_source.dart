import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class UserLocalDataSource {
  Future<String> getToken();
  Future<String> getUserId();
  Future<UserModel> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> clearCache();
  Future<void> saveToken(String token);
  Future<bool> isTokenAvailable();
}

@LazySingleton(as: UserLocalDataSource)
class HiveUserLocalDataSource implements UserLocalDataSource {
  static const String userBoxName = 'userBox';
  static const String tokenKey = 'token';
  static const String userKey = 'user';

  @override
  Future<void> saveToken(String token) async {
    final box = await Hive.openBox(userBoxName);
    await box.put(tokenKey, token);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox(userBoxName);
    await box.put(userKey, user);
  }

  @override
  Future<String> getToken() async {
    final box = await Hive.openBox(userBoxName);
    final token = box.get(tokenKey);
    if (token != null) {
      return token;
    } else {
      throw Exception('Token not found');
    }
  }

  @override
  Future<UserModel> getUser() async {
    final box = await Hive.openBox(userBoxName);
    final user = box.get(userKey);
    if (user != null && user is UserModel) {
      return user;
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<String> getUserId() async {
    final user = await getUser();
    return user.id; // ✅ Get user id from saved UserModel
  }

  @override
  Future<bool> isTokenAvailable() async {
    final box = await Hive.openBox(userBoxName);
    return box.containsKey(tokenKey);
  }

  @override
  Future<void> clearCache() async {
    final box = await Hive.openBox(userBoxName);
    await box.clear();
  }
}

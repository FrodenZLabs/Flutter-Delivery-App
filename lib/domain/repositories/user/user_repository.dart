import 'package:flutter_delivery_app/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<User> registerUser(User user);
  Future<User> loginUser(String email, String password);
  Future<User?> getUser(String id);
  Future<User> updateUser(User user);
}

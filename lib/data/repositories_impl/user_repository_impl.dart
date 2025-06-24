import 'package:flutter_delivery_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_delivery_app/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  UserRepositoryImpl(this.remote, this.local);

  @override
  Future<User> loginUser(String email, String password) async {
    final user = await remote.loginUser(email, password);
    await local.cacheUser(user);
    return user;
  }

  @override
  Future<User?> getUser(String id) async {
    try {
      return await remote.getUser(id);
    } catch (_) {
      return await local.getCachedUser();
    }
  }

  @override
  Future<User> registerUser(User user) async {
    final model = UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      password: user.password,
      imageUrl: user.imageUrl,
    );
    final remoteUser = await remote.registerUser(model);
    await local.cacheUser(remoteUser);
    return remoteUser;
  }

  @override
  Future<User> updateUser(User user) async {
    final model = UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      password: user.password,
      imageUrl: user.imageUrl,
    );
    final updated = await remote.updateUser(model);
    await local.cacheUser(updated);
    return updated;
  }
}

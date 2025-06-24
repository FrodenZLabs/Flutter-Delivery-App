import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<User?> call(String id) => repository.getUser(id);
}

import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:flutter_delivery_app/data/repositories_impl/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemote;
  late MockUserLocalDataSource mockLocal;

  final user = UserModel(
    id: '1',
    firstName: 'Steve',
    lastName: 'Kibe',
    email: 'kibe@example.com',
    password: 'pass123',
    imageUrl: null,
  );

  setUp(() {
    mockRemote = MockUserRemoteDataSource();
    mockLocal = MockUserLocalDataSource();
    repository = UserRepositoryImpl(mockRemote, mockLocal);
  });

  test('registerUser should call remote and cache locally', () async {
    when(mockRemote.registerUser(any)).thenAnswer((_) async => user);

    final result = await repository.registerUser(user);

    expect(result, user);
    verify(mockRemote.registerUser(any)).called(1);
    verify(mockLocal.cacheUser(any)).called(1);
  });

  test('loginUser should authenticate and cache locally', () async {
    when(
      mockRemote.loginUser(user.email, user.password),
    ).thenAnswer((_) async => user);

    final result = await repository.loginUser(user.email, user.password);

    expect(result, user);
    verify(mockRemote.loginUser(user.email, user.password)).called(1);
    verify(mockLocal.cacheUser(user)).called(1);
  });

  test('getUser should return from remote if available', () async {
    when(mockRemote.getUser(user.id)).thenAnswer((_) async => user);

    final result = await repository.getUser(user.id);

    expect(result, user);
  });

  test('updateUser should update remote and cache locally', () async {
    when(mockRemote.updateUser(any)).thenAnswer((_) async => user);

    final result = await repository.updateUser(user);

    expect(result.id, '1');
    verify(mockLocal.cacheUser(user)).called(1);
  });
}

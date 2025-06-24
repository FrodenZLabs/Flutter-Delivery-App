import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late UpdateUser updateUser;
  late MockUserRepository mockRepository;

  final user = User(
    id: '1',
    firstName: 'Steve',
    lastName: 'Kibe',
    email: 'kibe@example.com',
    password: 'securePass',
    imageUrl: 'http://img.png',
  );

  setUp(() {
    mockRepository = MockUserRepository();
    updateUser = UpdateUser(mockRepository);
  });

  test('should update user and return updated entity', () async {
    when(mockRepository.updateUser(user)).thenAnswer((_) async => user);

    final result = await updateUser(user);

    expect(result, user);
    verify(mockRepository.updateUser(user)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

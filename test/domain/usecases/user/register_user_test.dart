import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late RegisterUser registerUser;
  late MockUserRepository mockRepository;

  final user = User(
    id: '1',
    firstName: 'Steve',
    lastName: 'Kibe',
    email: 'kibe@example.com',
    password: 'securePass',
    imageUrl: null,
  );

  setUp(() {
    mockRepository = MockUserRepository();
    registerUser = RegisterUser(mockRepository);
  });

  test('should register a user using the repository', () async {
    when(mockRepository.registerUser(user)).thenAnswer((_) async => user);

    final result = await registerUser(user);

    expect(result, user);
    verify(mockRepository.registerUser(user)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

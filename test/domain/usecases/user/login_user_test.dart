import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late LoginUser loginUser;
  late MockUserRepository mockRepository;

  const email = 'kibe@example.com';
  const password = 'securePass';

  final user = User(
    id: '1',
    firstName: 'Steve',
    lastName: 'Kibe',
    email: email,
    password: password,
    imageUrl: null,
  );

  setUp(() {
    mockRepository = MockUserRepository();
    loginUser = LoginUser(mockRepository);
  });

  test('should login user using email and password', () async {
    when(
      mockRepository.loginUser(email, password),
    ).thenAnswer((_) async => user);

    final result = await loginUser(email, password);

    expect(result, user);
    verify(mockRepository.loginUser(email, password)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

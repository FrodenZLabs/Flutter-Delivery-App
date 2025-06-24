import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late GetUser getUser;
  late MockUserRepository mockRepository;

  const userId = '1';

  final user = User(
    id: userId,
    firstName: 'Steve',
    lastName: 'Kibe',
    email: 'kibe@example.com',
    password: 'securePass',
    imageUrl: null,
  );

  setUp(() {
    mockRepository = MockUserRepository();
    getUser = GetUser(mockRepository);
  });

  test('should return user when found by ID', () async {
    when(mockRepository.getUser(userId)).thenAnswer((_) async => user);

    final result = await getUser(userId);

    expect(result, user);
    verify(mockRepository.getUser(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:flutter_delivery_app/domain/usecases/user/get_local_user_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/login_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/logout_use_case.dart';
import 'package:flutter_delivery_app/domain/usecases/user/register_use_case.dart';
import 'package:flutter_delivery_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockUserRepository mockRepository;
  late RegisterUser registerUser;
  late LoginUser loginUser;
  late GetUser getUser;
  late UpdateUser updateUser;
  late UserBloc userBloc;

  const testEmail = 'kibe@example.com';
  const testPassword = 'pass123';

  final user = User(
    id: '1',
    firstName: 'Steve',
    lastName: 'Kibe',
    email: testEmail,
    password: testPassword,
    imageUrl: null,
  );

  setUp(() {
    mockRepository = MockUserRepository();
    registerUser = RegisterUser(mockRepository);
    loginUser = LoginUser(mockRepository);
    getUser = GetUser(mockRepository);
    updateUser = UpdateUser(mockRepository);

    userBloc = UserBloc(
      registerUser: registerUser,
      loginUser: loginUser,
      getUser: getUser,
      updateUser: updateUser,
    );
  });

  tearDown(() => userBloc.close());

  group('RegisterUserEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserAuthenticated] on successful register',
      build: () {
        when(mockRepository.registerUser(user)).thenAnswer((_) async => user);
        return userBloc;
      },
      act: (bloc) => bloc.add(RegisterUserEvent(user)),
      expect: () => [UserLoading(), UserAuthenticated(user)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] on register failure',
      build: () {
        when(mockRepository.registerUser(user)).thenThrow(Exception('fail'));
        return userBloc;
      },
      act: (bloc) => bloc.add(RegisterUserEvent(user)),
      expect: () => [UserLoading(), isA<UserError>()],
    );
  });

  group('LoginUserEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserAuthenticated] on successful login',
      build: () {
        when(
          mockRepository.loginUser(testEmail, testPassword),
        ).thenAnswer((_) async => user);
        return userBloc;
      },
      act: (bloc) => bloc.add(const LoginUserEvent(testEmail, testPassword)),
      expect: () => [UserLoading(), UserAuthenticated(user)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] on login failure',
      build: () {
        when(
          mockRepository.loginUser(testEmail, testPassword),
        ).thenThrow(Exception('fail'));
        return userBloc;
      },
      act: (bloc) => bloc.add(const LoginUserEvent(testEmail, testPassword)),
      expect: () => [UserLoading(), isA<UserError>()],
    );
  });

  group('GetUserEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserAuthenticated] on successful fetch',
      build: () {
        when(mockRepository.getUser(user.id)).thenAnswer((_) async => user);
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserEvent(user.id)),
      expect: () => [UserLoading(), UserAuthenticated(user)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserUnauthenticated] if user is null',
      build: () {
        when(mockRepository.getUser('99')).thenAnswer((_) async => null);
        return userBloc;
      },
      act: (bloc) => bloc.add(const GetUserEvent('99')),
      expect: () => [UserLoading(), UserUnauthenticated()],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] on fetch failure',
      build: () {
        when(mockRepository.getUser(user.id)).thenThrow(Exception('fail'));
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserEvent(user.id)),
      expect: () => [UserLoading(), isA<UserError>()],
    );
  });

  group('UpdateUserEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserAuthenticated] on successful update',
      build: () {
        when(mockRepository.updateUser(user)).thenAnswer((_) async => user);
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUserEvent(user)),
      expect: () => [UserLoading(), UserAuthenticated(user)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] on update failure',
      build: () {
        when(mockRepository.updateUser(user)).thenThrow(Exception('fail'));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUserEvent(user)),
      expect: () => [UserLoading(), isA<UserError>()],
    );
  });

  group('LogoutUserEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserUnauthenticated]',
      build: () => userBloc,
      act: (bloc) => bloc.add(LogoutUserEvent()),
      expect: () => [UserUnauthenticated()],
    );
  });
}

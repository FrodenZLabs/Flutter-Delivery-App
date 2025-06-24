import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_all_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late GetAllServices useCase;
  late MockServiceRepository mockRepo;

  setUp(() {
    mockRepo = MockServiceRepository();
    useCase = GetAllServices(mockRepo);
  });

  final mockServices = [
    Service(
      id: '1',
      name: 'Dry Cleaning',
      subName: 'Expert Dry Cleaning',
      description: 'We clean your clothes!',
      imageUrl: 'http://image.com/dry.jpg',
      baseFee: 300,
      perKmFee: 50,
      available: true,
      openDay: 'Monday',
      closeDay: 'Friday',
      openTime: '8:00 AM',
      closeTime: '5:00 PM',
    ),
  ];

  test('should return list of services from repository', () async {
    // arrange
    when(mockRepo.getAllServices()).thenAnswer((_) async => mockServices);

    // act
    final result = await useCase();

    // assert
    expect(result, mockServices);
    verify(mockRepo.getAllServices());
    verifyNoMoreInteractions(mockRepo);
  });
}

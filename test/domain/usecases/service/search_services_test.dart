import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/usecases/service/search_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late SearchServices useCase;
  late MockServiceRepository mockRepo;

  setUp(() {
    mockRepo = MockServiceRepository();
    useCase = SearchServices(mockRepo);
  });

  final query = 'cleaning';

  final resultList = [
    Service(
      id: '1',
      name: 'Dry Cleaning',
      subName: 'Expert Dry Cleaning',
      description: 'Cleaning with care.',
      imageUrl: 'http://img.com/dry.jpg',
      baseFee: 300,
      perKmFee: 50,
      available: true,
      openDay: 'Monday',
      closeDay: 'Friday',
      openTime: '8:00 AM',
      closeTime: '5:00 PM',
    ),
  ];

  test(
    'should return list of services matching keyword from repository',
    () async {
      // Arrange
      when(mockRepo.searchServices(query)).thenAnswer((_) async => resultList);

      // Act
      final result = await useCase(query);

      // Assert
      expect(result, resultList);
      verify(mockRepo.searchServices(query));
      verifyNoMoreInteractions(mockRepo);
    },
  );
}

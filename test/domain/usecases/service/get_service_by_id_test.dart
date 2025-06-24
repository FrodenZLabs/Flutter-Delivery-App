import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_by_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late GetServiceById useCase;
  late MockServiceRepository mockRepo;

  setUp(() {
    mockRepo = MockServiceRepository();
    useCase = GetServiceById(mockRepo);
  });

  const serviceId = '1';

  final testService = Service(
    id: serviceId,
    name: 'Dry Cleaning',
    subName: 'Expert Dry Cleaning',
    description: 'Professional dry cleaning service.',
    imageUrl: 'http://example.com/image.jpg',
    baseFee: 300,
    perKmFee: 50,
    available: true,
    openDay: 'Monday',
    closeDay: 'Friday',
    openTime: '8:00 AM',
    closeTime: '5:00 PM',
  );

  test('should return service by ID from repository', () async {
    // Arrange
    when(
      mockRepo.getServiceById(serviceId),
    ).thenAnswer((_) async => testService);

    // Act
    final result = await useCase(serviceId);

    // Assert
    expect(result, testService);
    verify(mockRepo.getServiceById(serviceId));
    verifyNoMoreInteractions(mockRepo);
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSelectedDeliveryInfoUseCase
    implements UseCase<DeliveryInfo, NoParams> {
  final DeliveryInfoRepository repository;
  GetSelectedDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(NoParams params) async {
    return await repository.getSelectedDeliveryInfo();
  }
}

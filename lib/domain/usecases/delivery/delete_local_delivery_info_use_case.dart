import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteLocalDeliveryInfoUseCase implements UseCase<NoParams, NoParams> {
  final DeliveryInfoRepository repository;
  DeleteLocalDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.deleteLocalDeliveryInfo();
  }
}

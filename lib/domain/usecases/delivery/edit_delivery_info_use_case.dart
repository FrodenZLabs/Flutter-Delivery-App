import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/domain/repositories/delivery/delivery_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EditDeliveryInfoUseCase
    implements UseCase<DeliveryInfo, DeliveryInfoModel> {
  final DeliveryInfoRepository repository;
  EditDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfoModel params) async {
    return await repository.editDeliveryInfo(params);
  }
}

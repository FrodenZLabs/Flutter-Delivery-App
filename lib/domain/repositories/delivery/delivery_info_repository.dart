import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';

abstract class DeliveryInfoRepository {
  Future<Either<Failure, List<DeliveryInfo>>> getRemoteDeliveryInfo();
  Future<Either<Failure, List<DeliveryInfo>>> getLocalDeliveryInfo();
  Future<Either<Failure, DeliveryInfo>> addDeliveryInfo(
    DeliveryInfoModel params,
  );
  Future<Either<Failure, DeliveryInfo>> editDeliveryInfo(
    DeliveryInfoModel params,
  );
  Future<Either<Failure, DeliveryInfo>> selectDeliveryInfo(DeliveryInfo params);
  Future<Either<Failure, DeliveryInfo>> getSelectedDeliveryInfo();
  Future<Either<Failure, NoParams>> deleteLocalDeliveryInfo();
}

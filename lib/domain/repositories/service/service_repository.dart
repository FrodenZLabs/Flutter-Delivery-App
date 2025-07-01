import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/domain/entities/service/service_response.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_use_case.dart';

abstract class ServiceRepository {
  /// Fetch all available services
  Future<Either<Failure, ServiceResponse>> getRemoteServices(
    FilterServiceParams params,
  );
  Future<Either<Failure, ServiceResponse>> getLocalServices(
    FilterServiceParams params,
  );
}

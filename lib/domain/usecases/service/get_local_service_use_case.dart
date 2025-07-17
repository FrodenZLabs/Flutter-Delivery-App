import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/service/service_response.dart';
import 'package:flutter_delivery_app/domain/repositories/service/service_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLocalServiceUseCase implements UseCase<ServiceResponse, NoParams> {
  final ServiceRepository repository;

  GetLocalServiceUseCase(this.repository);

  @override
  Future<Either<Failure, ServiceResponse>> call(NoParams params) async {
    return await repository.getLocalServices();
  }
}

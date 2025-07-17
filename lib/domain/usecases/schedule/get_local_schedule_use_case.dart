import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLocalScheduleUseCase implements UseCase<List<Schedule>, NoParams> {
  final ScheduleRepository repository;

  GetLocalScheduleUseCase(this.repository);

  @override
  Future<Either<Failure, List<Schedule>>> call(NoParams params) async {
    return await repository.getLocalSchedulesByUser();
  }
}

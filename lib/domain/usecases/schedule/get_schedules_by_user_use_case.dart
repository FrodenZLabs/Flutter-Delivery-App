import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSchedulesByUserUseCase
    implements UseCase<List<Schedule>, ScheduleModel> {
  final ScheduleRepository repository;

  GetSchedulesByUserUseCase(this.repository);

  @override
  Future<Either<Failure, List<Schedule>>> call(ScheduleModel params) async {
    return await repository.getSchedulesByUser(params);
  }
}

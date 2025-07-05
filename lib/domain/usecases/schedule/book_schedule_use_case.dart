import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/usecases/usecase.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';
import 'package:flutter_delivery_app/domain/repositories/schedule/schedule_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BookScheduleUseCase implements UseCase<Schedule, ScheduleModel> {
  final ScheduleRepository repository;

  BookScheduleUseCase(this.repository);

  @override
  Future<Either<Failure, Schedule>> call(ScheduleModel params) async {
    return await repository.bookSchedule(params);
  }
}

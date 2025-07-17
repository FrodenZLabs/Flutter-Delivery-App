import 'package:dartz/dartz.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/domain/entities/schedule/schedule.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, Schedule>> bookSchedule(ScheduleModel params);
  Future<Either<Failure, Schedule>> updateSchedule(ScheduleModel params);
  Future<Either<Failure, List<Schedule>>> getSchedulesByUser(
    ScheduleModel params,
  );
  Future<Either<Failure, List<Schedule>>> getLocalSchedulesByUser();
}

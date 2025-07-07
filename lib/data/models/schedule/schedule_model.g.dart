// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleModelAdapter extends TypeAdapter<ScheduleModel> {
  @override
  final int typeId = 3;

  @override
  ScheduleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      serviceId: fields[2] as String,
      deliveryInfoId: fields[3] as String,
      scheduleDate: fields[4] as DateTime,
      scheduleTime: fields[5] as String,
      status: fields[6] as String,
      driverId: fields[7] as String?,
      driverName: fields[8] as String?,
      driverImage: fields[9] as String?,
      driverContact: fields[10] as String?,
      vehicleInfo: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.serviceId)
      ..writeByte(3)
      ..write(obj.deliveryInfoId)
      ..writeByte(4)
      ..write(obj.scheduleDate)
      ..writeByte(5)
      ..write(obj.scheduleTime)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.driverId)
      ..writeByte(8)
      ..write(obj.driverName)
      ..writeByte(9)
      ..write(obj.driverImage)
      ..writeByte(10)
      ..write(obj.driverContact)
      ..writeByte(11)
      ..write(obj.vehicleInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

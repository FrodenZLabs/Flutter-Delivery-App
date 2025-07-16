// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceModelAdapter extends TypeAdapter<ServiceModel> {
  @override
  final int typeId = 0;

  @override
  ServiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      subName: fields[2] as String,
      description: fields[3] as String,
      imageUrl: fields[4] as String,
      baseFee: fields[5] as double,
      perKmFee: fields[6] as double,
      available: fields[7] as bool,
      openDay: fields[8] as String,
      closeDay: fields[9] as String,
      openTime: fields[10] as String,
      closeTime: fields[11] as String,
      averageRating: fields[12] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.subName)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.baseFee)
      ..writeByte(6)
      ..write(obj.perKmFee)
      ..writeByte(7)
      ..write(obj.available)
      ..writeByte(8)
      ..write(obj.openDay)
      ..writeByte(9)
      ..write(obj.closeDay)
      ..writeByte(10)
      ..write(obj.openTime)
      ..writeByte(11)
      ..write(obj.closeTime)
      ..writeByte(12)
      ..write(obj.averageRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

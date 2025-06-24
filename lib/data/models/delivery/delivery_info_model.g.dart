// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryInfoModelAdapter extends TypeAdapter<DeliveryInfoModel> {
  @override
  final int typeId = 2;

  @override
  DeliveryInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryInfoModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      address: fields[2] as String,
      city: fields[3] as String,
      contactNumber: fields[4] as String,
      isDefault: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryInfoModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.contactNumber)
      ..writeByte(5)
      ..write(obj.isDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveDB.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDBAdapter extends TypeAdapter<HiveDB> {
  @override
  final int typeId = 1;

  @override
  HiveDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDB(
      main: fields[0] as Main,
      clouds: fields[1] as Clouds,
      weather: (fields[3] as List?)?.cast<Weather>(),
      wind: fields[2] as Wind,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDB obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.main)
      ..writeByte(1)
      ..write(obj.clouds)
      ..writeByte(2)
      ..write(obj.wind)
      ..writeByte(3)
      ..write(obj.weather);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
